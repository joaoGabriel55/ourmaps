import { getUserIdByToken } from "$lib/jwt";
import { findCustomMap } from "$lib/api/custom-maps/find";
import { makeOurMapsAPI } from "$lib/api/http-client";
import { redirect } from "@sveltejs/kit";

export const load = async ({ cookies, params }) => {
  const token = cookies.get("auth_token") || "";
  const userId = getUserIdByToken(token);

  if (!token) {
    throw redirect(303, "/login");
  }

  const response = await findCustomMap(params.id, makeOurMapsAPI(token));

  if (response.status === 200 && response.data) {
    return { map: response.data, token, userId };
  } else if (response.status === 403) {
    throw redirect(303, "/not-allowed");
  }
};
