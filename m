Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA75B5AE6
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Sep 2022 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiILNKW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Sep 2022 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiILNKO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Sep 2022 09:10:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5651F2D8
        for <linux-scsi@vger.kernel.org>; Mon, 12 Sep 2022 06:10:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id p5so10479875ljc.13
        for <linux-scsi@vger.kernel.org>; Mon, 12 Sep 2022 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=9N6hXNj+dLdaOvEgDNBHGBlZn0Js/WQ/9okD59gmlW0=;
        b=RyghqemhYQEKnj8qCDs0nazpmksIE1RM1R5YlHAi1zoS0pI0fUreobRhyeLoRiA0aV
         jAtMV2iM+BPVaCyNspL5mnSOuu3FeomHDnvLM+/A+02L+1V8tLWh/4uvXqmqhFUccX7n
         OhIx2+p0ILRwkthBGSgUbaR3N+1zZY0l/bS6OP35sQ/FzD9k8HWS53yV4kNTTxchWLnE
         AtLYKQwBd1Anr0T9g4p/2T6TzMHQsaGjLgNJu2rOgRcI3YcyDafVx+wPZStIAT3t8/Fh
         LnCnHrW+jUmckRMWNzOHwe79nb4XmovVXjTvVjLpM6hZzKHylExZCyQiP2OnvZcCqXDp
         +Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9N6hXNj+dLdaOvEgDNBHGBlZn0Js/WQ/9okD59gmlW0=;
        b=s01K8gnc8Mpg1Cj63R3r+We4usGUG7Akzv/lmSnwX4oP4QKRCiOD4vQOdnaFMJHJxU
         boxNFzqO3AKRh4SB7mdCfE8rGY9dOtkdtd8CtFmYLfxJ9xkdIdLuo8d2fommaifZ+Kne
         dqW5Qyf3QZU1HgS2jEdi1wyrtigqN29NO+cNANfzMxLllycn3VyHcrdl7PEbZ/yeOgrh
         cJOS1fLCU8FV4LN/yUT2jZmEQg75fRBvFstd2m32PshsBrqai7/qye7tiVjVlCHjfjkX
         znpueA2WAt1HriaiPToDeeAUGLjylFyX9zFVVFslmvsr7SBIBcLodlDq1uomQWkwYRiz
         iEIg==
X-Gm-Message-State: ACgBeo0yku4vBA1Rkozm5fGdIR2hMn0fhVLG8UwDu9welFV3koFA3B9E
        AnQaX0sBdY5gwG5xeMj6p2zh4T4OX8G/W08ozA==
X-Google-Smtp-Source: AA6agR6Z2+nwB8KRxgYZDFN2Zn2tmhc3FTRNN4PQZWgHCEsRTH91MQrdcaozpOnDO6/blK019o6ACMo/Ab6orfD+Ndw=
X-Received: by 2002:a2e:9918:0:b0:26b:ffa6:e431 with SMTP id
 v24-20020a2e9918000000b0026bffa6e431mr2179000lji.373.1662988210912; Mon, 12
 Sep 2022 06:10:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:750:b0:1e7:2f02:63f with HTTP; Mon, 12 Sep 2022
 06:10:10 -0700 (PDT)
Reply-To: michellegoodman035@gmail.com
From:   Michelle Goodman <michellegoodman035@gmail.com>
Date:   Mon, 12 Sep 2022 13:10:10 +0000
Message-ID: <CAPJ5U19=Ge5aHf_ApWC6gZnT1nd4M1UNmPNhxBvnbie0=cWhcg@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Vielen Dank.
