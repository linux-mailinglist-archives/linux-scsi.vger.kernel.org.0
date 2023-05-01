Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA06F30D3
	for <lists+linux-scsi@lfdr.de>; Mon,  1 May 2023 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjEAMYI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 1 May 2023 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEAMYG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 1 May 2023 08:24:06 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3221B6
        for <linux-scsi@vger.kernel.org>; Mon,  1 May 2023 05:24:04 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-5ef420b51adso11477306d6.0
        for <linux-scsi@vger.kernel.org>; Mon, 01 May 2023 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682943843; x=1685535843;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+IMQyG08SdQLNbyRHdHEj2dhFYoHP3MS5X9DSwFtrnk=;
        b=krSJBXJUhf5SWfhB4vJbJuaOV6mQ2xffj2gv26YaIi3Rt5OHUGhBv5UfgE7IQG4+rX
         t3WqIOy2MREcWvCW772kfU/UmWgT/TPzGiN4fzYZ6B9GbFS12lCuu2lMqhlHbfli5TlB
         vUCrSgrPhN88uIYznEi1n83QchYeJyDQLpxCPcVBFI+6oNKb/5w0ebhgIuelPSHKp60E
         Jx7EF88oePkzoyTvw9//bAjHZiBJ6PkNK17ktr1Mm5rozDZQpGrELfgHpIwpPcHC4ijG
         DhxFegh9uCarDnqXTUHoZNH0g7o2n/b1TRAF0w0nNNblPh1pHdxJ9yXgf25n/Dtn2gcr
         XAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682943843; x=1685535843;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IMQyG08SdQLNbyRHdHEj2dhFYoHP3MS5X9DSwFtrnk=;
        b=ccytjymmzPwIE2W2n0rkOK/Rgh1JUNrhcR2XqbTVePRDTyua7gDZrXm/2Zc0t2XKlk
         reOkW2msMyZjGT0ti7Oir4Bt92Axyph3DSCfGYpUqc8iCEv+qJ+1F3XPXx2+X9wRyEhU
         2qARDZv3wHWYgZi9ttBmHIa4RmbiFDIeRhoyGeUP9hFNZpG5A1cWGpKMYR/eKSptkO88
         he6qMnH5vM4+rsgG0bS7xwFgJExBqYBt3uZzV1W0s9vFKlZ1Xg9VXbArUNcWY8KVWh6t
         fNcOkW/gkJ1cUlPeRdfPPEwIjogtbgqhSpNWDYSZZXBtbwodW4iVLFzd1m8XSKmasA6W
         Gzag==
X-Gm-Message-State: AC+VfDzCJrH5ID3rXOyMHpysDrkDQydEUGHj1nqa5XflROch5lQN1xM5
        zm3HAeE5yOUBLlUErlEMl9OJ9U6v44nrJHsYASY=
X-Google-Smtp-Source: ACHHUZ7/sYnGTAYpgVOlH8ccCGOOKWCBLY7BZszFG2+7kg2kQuZl7hW7kbn3jym7b+yuk1KMGAsEwSaP01oYsorq7nI=
X-Received: by 2002:a05:6214:3011:b0:5f9:ba55:395f with SMTP id
 ke17-20020a056214301100b005f9ba55395fmr17891252qvb.52.1682943843506; Mon, 01
 May 2023 05:24:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa56:0:b0:5ef:5e02:42fb with HTTP; Mon, 1 May 2023
 05:24:02 -0700 (PDT)
From:   "Moha;ed Faye Lamine" <m.fayechambersl@gmail.com>
Date:   Mon, 1 May 2023 12:24:02 +0000
Message-ID: <CAAZjU91x0MCXvL8AbcnfzLVQ424Yv8bWm_CyWGpsTfAmyZrRVg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [m.fayechambersl[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Director


  I am Moyamba Susan looking forward to
investing in a lucrative business
  venture in your country.

  Meanwhile, i need to be sure you can
offer the assistance i need as a
  business partner.I would like you to
transfer US$6.5 million on my behalf
  which is deposited by my late father
.

  please can you help , to have this
fund transferred to your country and
  we will fly to join you after the
transfer of the money?.I will give you
  the 20% of the total fund for your
assistance investment.

  Please reply to susanmoyamba1@yahoo.com
to assure me of your partnership
  otherwise ignore.

  You will receive specifications and
details when i receive your response.


  Best regards,

  Moyamba Susan
