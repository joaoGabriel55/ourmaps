import { createUser, type UserInput } from "$lib/api/users/create";
import { makeOurMapsAPI } from "../http-client";

export const signUp = async (payload: UserInput) => {
  try {
    return await createUser(payload, makeOurMapsAPI());
  } catch (error: any) {
    return error;
  }
};
