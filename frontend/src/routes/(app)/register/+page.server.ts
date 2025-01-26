import { signUp } from "$lib/api/auth";
import { userStore } from "$lib/stores/user";
import { fail, redirect } from "@sveltejs/kit";

export const actions = {
  default: async ({ request }) => {
    const formData = await request.formData();

    const name = formData.get("name");
    const email = formData.get("email");
    const password = formData.get("password");
    const confirmPassword = formData.get("confirmPassword");

    if (!name || !email || !password || !confirmPassword) {
      return {
        status: 400,
        body: { error: "All fields are required", success: false },
      };
    }

    if (password !== confirmPassword) {
      return {
        status: 400,
        body: {
          error: "Passwords do not match",
          success: false,
        },
      };
    }

    const response = await signUp({
      name: name.toString(),
      email: email.toString(),
      password: password.toString(),
    });

    if (response.status !== 201) {
      console.error(response.data);

      return fail(response.status || 500, { error: 'Error!' });
    }

    userStore.set(response.data);

    //redirect user to the protected page
    throw redirect(302, "/login");
  },
};
