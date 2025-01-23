import { userStore } from "$lib/stores/user.js";
import { redirect } from "@sveltejs/kit";

export function load({ cookies }) {
  cookies.delete("auth_token", { path: "/" });
  userStore.set(null);

  throw redirect(303, "/login");
}
