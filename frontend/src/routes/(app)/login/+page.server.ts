import { signIn } from "$lib/api/auth";
import { makeOurMapsAPI } from "$lib/api/http-client.js";

import { redirect } from "@sveltejs/kit";

export const actions = {
  default: async ({ cookies, request }) => {
    const formData = await request.formData();

    const email = formData.get("email");
    const password = formData.get("password");

    if (!email || !password) {
      return {
        status: 400,
        body: {
          error: "All fields are required",
          success: false,
        },
      };
    }

    const response = await signIn(
      {
        email: email.toString(),
        password: password.toString(),
      },
      makeOurMapsAPI()
    );

    if (!response.data || response.status !== 200) {
      return {
        status: 400,
        body: {
          error: "Invalid credentials",
          success: false,
        },
      };
    }

    cookies.set("auth_token", response.data.token, {
      httpOnly: true,
      path: "/",
    });

    cookies.set("user", JSON.stringify({ email }), {
      httpOnly: true,
      path: "/",
    });

    throw redirect(303, "/");
  },
};
