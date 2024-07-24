import { Router } from "express";
import { AuthController } from "../controllers";
import { isAuthenticated } from "../middlewares";

const AuthRouter = Router();

AuthRouter.route("/login").post(AuthController.login);

AuthRouter.route("/logout").post(isAuthenticated, AuthController.logout);

AuthRouter.route("/forgot-password").post(AuthController.forgotPassword);

AuthRouter.route("/check").get(isAuthenticated, AuthController.checkAuth);

export default AuthRouter;
