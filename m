Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDC053E2BD
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jun 2022 10:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiFFICZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Jun 2022 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiFFICN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 Jun 2022 04:02:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB742DD76
        for <linux-scsi@vger.kernel.org>; Mon,  6 Jun 2022 01:02:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c2so17690596edf.5
        for <linux-scsi@vger.kernel.org>; Mon, 06 Jun 2022 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=3FaCpxcsWD+oaofcA3Y4DB5TwtQsfV7B/aOuz+eAXuk=;
        b=jmZmkE2ICasfVeCIMUxSByRKCghYLcFIwYSWaUvVLZW+kkvonGVoy8HplIheG4sXXR
         9CiWod8mg7XajK39q5dXjZHMsGlZU7/sRz2nVrI3fzsTTjgqinWbure6d/vFNyxyecWT
         l019s/cjUBOIysJEbe80UG/k16ZPZJgc+//015BDMbeln63uo3ssxKtmYC9uC38KHz6D
         oI+AkOvXrLJcuUssA7ojlqq2QGwuy8Pz+moGVMyeMbtisuSY5BFqPQ3yTuJ4GxX3M1MG
         z804khBvB2Yia0HFQI3jgY32IAyvIZEJpxx9YICD07YKFazh+6yyTJdSMggDhz7ze7Ic
         5tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=3FaCpxcsWD+oaofcA3Y4DB5TwtQsfV7B/aOuz+eAXuk=;
        b=vIrkPWNy7ujjkwvcpo90In997rwnyA45ZJQXMeM+zKIi8IL22ebEoJCFTv6f4MYGNy
         ra1jspcXZCK0TVYufdBhwHp6TVZbjuSBrSiI3jETQjPaLITADPa+pU8QVIzL2waO9MYK
         5zs7CzqRUpvTnZWxNDdARWui/NAv9TqqCGZqYt/BoMc55/22K5tr9b6dfSSK9RjynNHc
         Wew0x/yViJADFloEp2jhQVqwNbnAgYo4zfyRrXU3CzUwo2XVbQq24yGrbnVHhK3/HedB
         U5Q6SSmhmLX+P5a1KCATdKuIpKTo0vjSj6d5+b2bbYfSZ8MGiZk4RgEulEN8ypzz0htT
         XB8g==
X-Gm-Message-State: AOAM530DwurbXQNDrYRKlysq4N669WJEpCKOa/1gnDUHyMW+HhEeomY7
        FMkqFSLal5/Um0N/E1I4e/iYxXPvcLLrtc+5jR4=
X-Google-Smtp-Source: ABdhPJy/ka5+5g97YJf6KmRtqeof5yS+GF2a30VeMa/CiXzP8uRDAqUfadfUGmpse6OmmNhMRTR9bWzfS0xHlXiNzz4=
X-Received: by 2002:a05:6402:438a:b0:42e:985:4944 with SMTP id
 o10-20020a056402438a00b0042e09854944mr24376950edc.283.1654502530012; Mon, 06
 Jun 2022 01:02:10 -0700 (PDT)
MIME-Version: 1.0
Sender: midonicolas84@gmail.com
Received: by 2002:a55:c10e:0:b0:18a:9c26:7dbb with HTTP; Mon, 6 Jun 2022
 01:02:08 -0700 (PDT)
From:   Tomani David <davidtomani24@gmail.com>
Date:   Mon, 6 Jun 2022 08:02:08 +0000
X-Google-Sender-Auth: KwyWVR-ki7RHffHd1TYNubkTpsk
Message-ID: <CAE_PYmrprZKqtHSz=vQxGO1biPLC3XPdGCnMxKxj3H_Nc=YjfA@mail.gmail.com>
Subject: I have a message for you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Good morning,

Did you receive my previous email? I'm still waiting for your answer.


Regards,
Mr. David
