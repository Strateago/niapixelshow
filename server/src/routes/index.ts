import { Router } from "express";
import UserRouter from "./UserRoutes";
import CartRouter from "./CartRoutes";
import PromotionRouter from "./PromotionRoutes";
import AuthRouter from "./AuthRoutes";
import ProductRouter from "./ProductRoutes";
import CategoryRouter from "./CategoryRoutes";
import OrderRouter from "./OrderRoutes";
import EmailRouter from "./EmailRoutes";

const router = Router();

router.use("/user", UserRouter);
router.use("/cart", CartRouter);
router.use("/promotion", PromotionRouter);
router.use("/auth", AuthRouter);
router.use("/product", ProductRouter);
router.use("/category", CategoryRouter);
router.use("/order", OrderRouter);
router.use("/email", EmailRouter);

router.route("/").get((_, res) => {
  res.status(200).send("Made with ❤️ by @ribeirowski");
});

export default router;
