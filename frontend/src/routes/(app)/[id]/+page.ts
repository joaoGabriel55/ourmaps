import { error } from "@sveltejs/kit";

export const load = async ({ data }) => {
  if (data.map) {
    return {
      map: data.map,
      token: data.token,
      userId: data.userId,
    };
  }

  error(404, "Not found");
};

export const ssr = false;
