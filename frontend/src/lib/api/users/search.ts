import type { HTTPClient } from "../http-client";

export const searchUsers = async (query: string, httpClient: HTTPClient) => {
  try {
    const { data } = await httpClient.get("/users", {
      query,
    });

    return data;
  } catch (error: any) {
    throw error;
  }
};
