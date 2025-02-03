import type { User } from "$core/user";
import { errorHandler } from "../helpers/errors";
import type { HTTPClient } from "../http-client";

export const findUserById = async (id: string, httpClient: HTTPClient) => {
  try {
    const response = await httpClient.get<User>(`/users/${id}`);

    return response.data;
  } catch (error: any) {
    return null;
  }
};
