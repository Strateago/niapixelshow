import { Request, Response, NextFunction } from "express";
import { adminAuth, firestoreDB } from "../services/firebase/firebaseAdmin";
import { auth } from "../services/firebase/firebase";
import {
  sendEmailVerification,
  signInWithEmailAndPassword,
} from "firebase/auth";
import { User, UpdateUser } from "../DTOs";
import { hash } from "bcryptjs";

interface CustomRequest extends Request {
  user?: any; // Adiciona a propriedade 'user' ao objeto Request
}

// Função auxiliar para definir a reivindicação is_admin
const setAdminClaim = async (uid: string) => {
  await adminAuth.setCustomUserClaims(uid, { is_admin: true });
};

class UserController {
  // Criação de um novo usuário
  async create(req: Request, res: Response, next: NextFunction) {
    try {
      const userData = User.parse(req.body);

      // Verifica se já existe um usuário com o mesmo e-mail
      const existsUserWithEmail = await firestoreDB
        .collection("users")
        .where("email", "==", userData.email)
        .get();
      if (!existsUserWithEmail.empty) {
        return res.status(400).json({ message: "Email already in use" });
      }

      // Hash da senha
      const hashedPassword = await hash(userData.password, 6);

      // Crie o usuário no Firebase Authentication
      const userRecord = await adminAuth.createUser({
        email: userData.email,
        password: userData.password,
        displayName: userData.name,
        disabled: false,
        emailVerified: false,
      });

      // Definir a reivindicação is_admin, se necessário
      if (userData.is_admin) {
        await setAdminClaim(userRecord.uid);
      }

      // Fazer login temporário para enviar o email de verificação
      const userCredential = await signInWithEmailAndPassword(
        auth,
        userData.email,
        userData.password
      );
      const user = userCredential.user;

      // Envia o e-mail de verificação para o usuário
      await sendEmailVerification(user);

      // Logout após enviar o email de verificação
      await auth.signOut();

      // Prepara as informações do usuário para salvar no Firestore, substituindo a senha pelo hash
      const userDataForFirestore = {
        ...userData,
        password: hashedPassword,
      };

      // Salva as informações do usuário no Firestore
      await firestoreDB
        .collection("users")
        .doc(userRecord.uid)
        .set(userDataForFirestore);

      res
        .status(201)
        .json({
          message: "User created successfully. Verification email sent.",
          uid: userRecord.uid,
          email: userData.email,
          name: userData.name,
        });
      return next();
    } catch (error) {
      return next(error);
    }
  }

  // Atualização dos dados de um usuário
  async update(req: CustomRequest, res: Response, next: NextFunction) {
    try {
      const userId = req.params.id;
      const userData = UpdateUser.parse(req.body);

      // Verifica se o usuário existe
      const userDoc = await firestoreDB.collection("users").doc(userId).get();
      if (!userDoc.exists) {
        return res.status(404).json({ message: "User not found" });
      }

      // Verifica se o usuário é o dono da conta ou um administrador
      if (req.user?.uid !== userId && !req.user?.is_admin) {
        return res.status(403).json({ message: "Permission denied" });
      }

            // Fazer o hash da senha caso ela tenha sido alterada
            if (userData.password) {
                userData.password = await hash(userData.password, 6);
            }

            // Atualiza as informações do usuário no Firestore
            await firestoreDB.collection('users').doc(userId).update(userData);

      res.status(200).json({ message: "User updated successfully" });
      return next();
    } catch (error) {
      return next(error);
    }
  }

  // Leitura de todos os usuários (apenas para administradores)
  async readAll(req: Request, res: Response, next: NextFunction) {
    try {
      const allUsers = await firestoreDB.collection("users").get();
      if (allUsers.empty) {
        return res.status(404).json({ message: "No users found" });
      }
      const usersData = allUsers.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));
      res.status(200).json(usersData);
      return next();
    } catch (error) {
      return next(error);
    }
  }

  // Leitura de um usuário por ID
  async readById(req: Request, res: Response, next: NextFunction) {
    try {
      const userId = req.params.id;
      const userDoc = await firestoreDB.collection("users").doc(userId).get();
      if (!userDoc.exists) {
        return res.status(404).json({ message: "User not found" });
      }
      const userData = userDoc.data();
      res.status(200).json({ id: userDoc.id, ...userData });
      return next();
    } catch (error) {
      return next(error);
    }
  }

  // Leitura de um usuário por e-mail
  async readByEmail(req: Request, res: Response, next: NextFunction) {
    try {
      const email = req.params.email;
      const userDoc = await firestoreDB
        .collection("users")
        .where("email", "==", email)
        .get();
      if (userDoc.empty) {
        return res.status(404).json({ message: "User not found" });
      }
      const userData = userDoc.docs[0].data();
      res.status(200).json({ id: userDoc.docs[0].id, ...userData });
      return next();
    } catch (error) {
      return next(error);
    }
  }

  // Verificação de e-mail de um usuário
  async verifyEmail(req: Request, res: Response, next: NextFunction) {
    try {
      const email = req.params.email;
      const user = await adminAuth.getUserByEmail(email);
      if (user.emailVerified) {
        return res.status(400).json({ message: "Email already verified" });
      }
      await adminAuth.updateUser(user.uid, { emailVerified: true });

      res.status(200).json({ message: "Email verified" });
      return next();
    } catch (error) {
      return next(error);
    }
  }

  // Deleção de um usuário
  async delete(req: CustomRequest, res: Response, next: NextFunction) {
    try {
      const userId = req.params.id;

      const userDoc = await firestoreDB.collection("users").doc(userId).get();
      if (!userDoc.exists) {
        return res.status(404).json({ message: "User not found" });
      }

      // Verifica se o usuário é o dono da conta ou um administrador
      if (req.user?.uid !== userId && !req.user?.is_admin) {
        return res.status(403).json({ message: "Permission denied" });
      }

      // Deleta o usuário do Firestore e do Firebase Authentication
      await firestoreDB.collection("users").doc(userId).delete();
      await adminAuth.deleteUser(userId);

      res.status(200).json({ message: "User deleted successfully" });
      return next();
    } catch (error) {
      return next(error);
    }
  }
}

export default new UserController();
