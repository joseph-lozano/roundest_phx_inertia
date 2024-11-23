import { router } from "@inertiajs/react";
import { Socket } from "phoenix";

declare global {
  interface Window {
    userToken: string;
  }
}

let socket = new Socket("/socket", { params: { token: window.userToken } });
socket.connect();

let channel = socket.channel("results", {});
channel.join().receive("error", () => {
  console.error("Unable to join");
});

channel.on("update", () => {
  router.reload();
});

export default socket;
