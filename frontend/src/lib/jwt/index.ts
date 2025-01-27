import { jwtDecode } from "jwt-decode";

export const getUserIdByToken = (token: string) => {
  const decoded = jwtDecode<{ user_id: string }>(token);

  return decoded.user_id;
};
