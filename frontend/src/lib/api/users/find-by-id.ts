import type { User } from "$core/user";
import type { HTTPClient } from "../http-client";

export const findUserById = async (id: string, httpClient: HTTPClient) => {
  const { data } = await httpClient.get<User>(`/users/${id}`);

  return data;
};
