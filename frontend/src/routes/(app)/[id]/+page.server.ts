import { redirect } from "@sveltejs/kit";

export const load = async ({ cookies }) => {
  const token = cookies.get("auth_token") || "";

  if (!token) {
    throw redirect(303, "/login");
  }
};
