Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BE165D34E
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Jan 2023 13:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbjADMza (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Jan 2023 07:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbjADMyz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Jan 2023 07:54:55 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3101DDE8
        for <linux-scsi@vger.kernel.org>; Wed,  4 Jan 2023 04:54:53 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id h8so16204962qkk.8
        for <linux-scsi@vger.kernel.org>; Wed, 04 Jan 2023 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=BQfo1+41q2NZR57Q7BFlMODaOza2AgrRvUpAp3daCd4t1w84OEhFtXAM1g7CkVTr/y
         mvXWkJvXCDM96Iy3cSf9E37Th3uZX5TzmwlIsHFzK3DAyLuSjJ8d3uR9drr/ahkzPGkt
         iW+sw+gZOJCd7bumtfoM4UR2xOfXz6tdmGq2f+IJJhoSBazdofAm5Gs9PxuweXnk264c
         knSGf1CtrqZScdeov1GoaGbl2sApMUXYjJGPCObPVA0UTlHx2t6+wdp4VOKHmsqLWM8X
         lQt15zqigA6uJCG+q37n0r4mLK1MKtsniT1i9jhRA9qlN9E2Mf0sYN4W9Jd0n+39BoCK
         yzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=NT14Ii1OZk/QsEhO9xWjGAGJwbGSisxcFKNWxguX32KvhaZDnRotLMTdOfHwyRC69D
         WfZisvw9cMHsM0nU8aY4RH4SqWXKs9Q2jD99Qkyz5EAUumyaXvMZL2K2WQqibt9pIiXH
         f3jCObMAJAEjIYN66pwdDT4t2MxAJHlitQPoiwvSeYOFXnvQZsbaEJs2uFjHSG6s1u+4
         E7tY3+daffKLSVPrIOBVx4tLUykDQK+eu7CGT2f5q/Fapuj1e4DmXDQHOMx3lPFRBZlk
         ZpQyN0NXCL17XsEb781iRbT9s7ubGQ9ulsJMuucU4en74pSS36Im9rgMcIX3CcT2lVEI
         BRUw==
X-Gm-Message-State: AFqh2kpOBxtkP26mtDWed13Wmask/8Q2aQmwzXeD2zQY8W8YptaVH0mE
        oyAmguTLRKNOUmbKgc/xNlmOfOiabmj0xWcS4mddPLtldts=
X-Google-Smtp-Source: AMrXdXuKXTvNK0aSB9vnyjtdhrZfKmRzvU9Jw1W0zhcD7x19AMFVNgTh5oL+8ilZBOfTDf/bL64QVz1mYULxa/ftADs=
X-Received: by 2002:ac8:568a:0:b0:3a9:688d:fad2 with SMTP id
 h10-20020ac8568a000000b003a9688dfad2mr1976067qta.646.1672836882017; Wed, 04
 Jan 2023 04:54:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6200:5d91:b0:4a5:78e9:2012 with HTTP; Wed, 4 Jan 2023
 04:54:41 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <mzsophie@gmail.com>
Date:   Wed, 4 Jan 2023 12:54:41 +0000
Message-ID: <CAEoj5=ZpJ15GRz-U33Ocbu5-P3Va+3bNv3476+mmJJ52cwx7tA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Seasons Greetings!

This will remind you again that I have not yet received your reply to
my last message to you.
