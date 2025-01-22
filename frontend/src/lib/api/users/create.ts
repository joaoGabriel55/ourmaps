import { ourMapsAPI } from "$lib/api/http-client";

export const createUser = async (user: any) => {
  await ourMapsAPI.post("/users", user);
};
