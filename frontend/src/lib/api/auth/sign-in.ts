import { type HTTPClient } from "$lib/api/http-client";

type Params = {
  email: string;
  password: string;
};

export const signIn = async (
  { email, password }: Params,
  httpClient: HTTPClient
) => {
  return await httpClient.post<{ token: string }>("/auth/login", {
    email,
    password,
  });
};
