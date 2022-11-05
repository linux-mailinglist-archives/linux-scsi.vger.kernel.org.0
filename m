Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF7561DA5F
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Nov 2022 13:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKEMkG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 5 Nov 2022 08:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKEMj7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 5 Nov 2022 08:39:59 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC42165A1
        for <linux-scsi@vger.kernel.org>; Sat,  5 Nov 2022 05:39:58 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13bd19c3b68so8212661fac.7
        for <linux-scsi@vger.kernel.org>; Sat, 05 Nov 2022 05:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=mu8m7znM9duu/MEuox3wxE9uI+enJzfHDrHCiCJ0dxXEnbtqlugP30RV4pUA4LaD8D
         DTqzL6R3iJdygnN0tebcl2jKMC1xnk2qmH9yHj5ZpYJsig0zgAkFbQEJMtQOsyMS9E9+
         9mZsd+BXbCYizoNZILloIeJgVKBYQDDlfcxWmhtehgP0gShVz6QbysTuA73O0zNW89oN
         M95vp9qd39mlLDduLYXTQkqHXtcuCB6sr4c0ysKpoCTw5s/vT8zmw06SHC/DLusZ9o66
         sNkDbmLIhAcJBtA+VmbRSjB+l+4rXBDt3pKOG75zF9L+vjSBjo5n2zZjo+rRsufLH5jZ
         6xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=bSP30QCHRWhH6l8Mk/OjC1sbAWTbeoOA/x7LZm+O7uZEfDTZhF7uO4DU1cUQ9BqPR8
         wiWo1vTAbGVxD+Ymiid3bI0vivrBkl9lmODjiLbcYIE84r53KxyUUsD2AMxJo1qLq9SW
         Y3A099qBITL6UKbtFgN1uiBHp1RijTR8rP9rfHJqqZgRrAgQf5GdiK409k3OHL8D45fj
         1QRMURyn5fBMavBzmZaaDtlkoFfdVoTa5TqJvKOLo1iGANrFYBM5ZLk6najNMhRCPiD3
         HGjZ/ZQo4G8ZJVMcNVSdPOGCyO7qe8oWxdR82QXYZKgvP2gLiKE+ihLX+2LwYdyM3K8F
         3wXg==
X-Gm-Message-State: ACrzQf2L3nCxUZ5qRRyxKkjJlZoodblbLTUkT7NC5Wyqufw07rymGSRr
        SdA+IS9NG2d6Z4C7Jc68jQKL3YcfZZfTWhrH1BBrxFUVh9o=
X-Google-Smtp-Source: AMsMyM5GFe2gsiMaHXHXvp99K7JeNN2UuK6dELDyLpsoJjIUkQcn4q3aD74FbKEapmwctM2YF8x1D4LMLHeg4fM3LVk=
X-Received: by 2002:a17:90b:4ac3:b0:213:3918:f276 with SMTP id
 mh3-20020a17090b4ac300b002133918f276mr57022678pjb.19.1667651987563; Sat, 05
 Nov 2022 05:39:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7301:2e91:b0:83:922d:c616 with HTTP; Sat, 5 Nov 2022
 05:39:47 -0700 (PDT)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <wamathaibenard@gmail.com>
Date:   Sat, 5 Nov 2022 15:39:47 +0300
Message-ID: <CAN7bvZKO8GxFn7CG_EtS_Of+AZ+KsuqTkq40Mq-yJDNrEHyakg@mail.gmail.com>
Subject: Geldspende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
Die Summe von 500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespende=
t.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
stefanopessia755@hotmail.com
