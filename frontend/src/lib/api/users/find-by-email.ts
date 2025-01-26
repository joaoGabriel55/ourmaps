import type { User } from "$core/user";
import type { HTTPClient } from "../http-client";

export const findUserByEmail = async (
  email: string,
  httpClient: HTTPClient
) => {
  const { data } = await httpClient.get<User>(`/users?email=${email}`);

  return data;
};
