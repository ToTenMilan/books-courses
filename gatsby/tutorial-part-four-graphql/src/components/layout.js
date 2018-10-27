import React from "react"
import { css } from "react-emotion"
import { StaticQuery, Link, graphql } from "gatsby"

import { rhythm } from "../utils/typography"

export default ({ children }) => (
  <StaticQuery
    query={graphql`
      query {
        site {
          siteMetadata {
            title
          }
        }
      }
    `
  }
    render = {data => (
      <div
        className={css`
          margin: 0 auto;
          max-width: 700px;
          padding: ${rhythm(2)};
          padding-top: ${rhythm(1.5)};
        `}
      >
        <Link to={`/`}>
          <h3
            className={css`
              margin-bottom: ${rhythm(2)};
              display: inline-block;
              font-style: normal;
            `}
          >
          <img src="https://scontent-sea1-1.cdninstagram.com/vp/c5a40e422a0a15a4b11930c96fa86332/5C2AF8CF/t51.2885-19/21911500_128420494549637_8885057948280160256_n.jpg" alt="harrpagan"/>
            HaRRpagan's Home
          </h3>
        </Link>
        <Link
          to={`/about/`}
          className={css`
            float: right;
          `}
        >
          about
        </Link>
        {children}
      </div>
    )}
  />
)