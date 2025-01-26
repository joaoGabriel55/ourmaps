import type { User } from "$core/user";
import type { HTTPClient } from "../http-client";

export type UserInput = Omit<User, "id" | "createdAt" | "updatedAt"> & {
  password: string;
};

export const createUser = async (user: UserInput, httpClient: HTTPClient) => {
  return await httpClient.post<User>("/users", user);
};
