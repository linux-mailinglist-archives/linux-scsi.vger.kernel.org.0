Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC815A12AD
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Aug 2022 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbiHYNtP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Aug 2022 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242396AbiHYNtN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Aug 2022 09:49:13 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53D3B5E6A
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 06:49:11 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id 67so20941128vsv.2
        for <linux-scsi@vger.kernel.org>; Thu, 25 Aug 2022 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=OhrrxA0+VtUH2OMYp4JdnIujQjBusCdPTL4Hk4sQ+XM=;
        b=glybJLCSmgF5dTQfa6lasQ6hXgpnrrkhwlQgXyGDhUXSZ/qFk9tV6u2WrUetuYSHxs
         CeilUBNorFUxnM2clUmm7O8U7Y7AezzOfO0+8KkDZB2BZaaAGK3HGxZqdvilEziUbegS
         CPPe/dL9VDYWN9uAFh4Ku4dY1mbaqod8wFVz0U4wT/3dfneYzL5n3LhBQE25GVFF2ERb
         FfaemThbQqVNYWrRVy2pCH5pbfoOGjteCgebZVqaEzSmx5gOkMmlJ2RfZrJWcXbDGBEc
         jICdM1ALPnZNP66pn17QW8QRd/SgSbPRN3lJIgD9JkUMyE+wQXU3fhkteaMHDREQll+m
         NY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=OhrrxA0+VtUH2OMYp4JdnIujQjBusCdPTL4Hk4sQ+XM=;
        b=oZ6PUO9YKTVRyhufiuzPfY6MxsByLOyJjbHZriRzcz+wtEYfZTQqkOt6n0CqWrX1Fz
         Vyi13QIsQdKVBwYIuxGpQ4F5qPaXEv0uJ8nlwU73kjuN8Ibr4QGacV3CkrVEs0oizzQw
         b1CumalYGZWmQp8lXN9P/TxN/0ekE5ItzE3HrZiSdOOiUiE4yd7JHREnKW8BMvHeIwyX
         UvoG2WS68LytYD7erz28X3GXJWgj9q5eTPkk+qU1Y4PeeitQJZk6SSqonHfu7TmV/c1W
         TbAT9b3gZ2+iQ8Kz9pQ2PBzgoAd8Us8i3RrdH8xTG3H0Thhlyi0R0S8mIs846Fh7xA5+
         LVxQ==
X-Gm-Message-State: ACgBeo1zhtafzk0P6xb2azcKnP0xzwzYd34NgfC1CAzlC2pgx/U4pFJN
        SGNT2NDiSxuvkD6cPufOMXG1UkML4E2tgKP6xzY=
X-Google-Smtp-Source: AA6agR720bz5vYy0j0uRtSlPTavLIYVOd6PrU3IP1dxXHBhvlgNrfHaHjvqjSnbinnD4FzLiHYtkYYRe2jJI9+6uTgg=
X-Received: by 2002:a67:ea51:0:b0:38a:8637:d959 with SMTP id
 r17-20020a67ea51000000b0038a8637d959mr1578917vso.2.1661435350802; Thu, 25 Aug
 2022 06:49:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:dd84:0:b0:2da:1bbe:5176 with HTTP; Thu, 25 Aug 2022
 06:49:10 -0700 (PDT)
Reply-To: franca.rose3@yahoo.com
From:   Franca Rose <roseharri3@gmail.com>
Date:   Thu, 25 Aug 2022 13:49:10 +0000
Message-ID: <CAGs5tX6gGbYtmcmQczGsYB1JsDZ_axM7qSQVx0u=dre+GF3aJw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4964]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [roseharri3[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [roseharri3[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [franca.rose3[at]yahoo.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2d listed in]
        [list.dnswl.org]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Hello,

i am trying to reach you hope this message get to
you.from Franca Rose
