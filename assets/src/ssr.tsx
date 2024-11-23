import { createInertiaApp } from "@inertiajs/react";
import axios from "axios";
import { renderToString } from "react-dom/server";
import Layout from "./components/Layout";
import "./main.css";

axios.defaults.xsrfHeaderName = "x-csrf-token";

type Page = {
  default: {
    layout: (page: any) => any;
  };
};

export function render(page: string) {
  return createInertiaApp({
    page,
    render: renderToString,
    resolve: async (name) => {
      const page = (await import(`./pages/${name}.tsx`)) as Page;
      page.default.layout =
        page.default.layout || ((page) => <Layout children={page} />);
      return page;
    },
    setup: ({ el, App, props }) => <App {...props} />,
  });
}
