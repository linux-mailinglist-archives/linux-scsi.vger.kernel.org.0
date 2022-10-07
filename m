Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924765F742A
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Oct 2022 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJGGWp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Oct 2022 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGGWo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Oct 2022 02:22:44 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8159BEAEC
        for <linux-scsi@vger.kernel.org>; Thu,  6 Oct 2022 23:22:41 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id d187so4099189vsd.6
        for <linux-scsi@vger.kernel.org>; Thu, 06 Oct 2022 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ee1g+DQVjaU7Ixdagx5xQpa1KUPAjcmCcKTt3iTyQbc=;
        b=nlWy561iwzw3ce+dKzSaIJFXC9kTXCw/2gFN1YA8RAEwElw0nM1wJNoAVQ14J2S11X
         ThLEm7WELTxG6GOtZPEKHCxJKPnHEkyLD4GA1r1NcBmOIYn1MbDkmaLWHDn9F9V1mVPg
         7uJPC63eS/Xu26e6RbByx0NUWuWfGm7zdJW0IcfMdEzInohF3YpDiRh32Wldbw4PKHvG
         t4KbW6oZNedKSUfqjMwpfh7au2GvkTAuJUfEQrxTif7LL0RElxdD6fbQDxUd715tOWAL
         xpdYT02aV7vmfte2v0Cl2EYuBQBnvo2htulwIZ7JdhK4auLf4TaF66XiaEOp6Av9bug+
         99YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ee1g+DQVjaU7Ixdagx5xQpa1KUPAjcmCcKTt3iTyQbc=;
        b=q+78eEiiDoLCBPmhFjCidjug5zINvLyF8OD8k4tGM3fsIJCWS8QxIKIR+G91ElFBN6
         XBFJWFDiX6CsFZwJdQeDgAnu0HKkXHPKVEdOVMz9t0YQUK5SqBOG2abvFYONGKziDaT/
         lJB7mHke37pTv5CSSvvP1MDoSdRupHo28JIbsp+Skj/jzd6qGecD3DvSyCa5pmVaIITO
         DiN+ooEvS2rzaDKRWc3Cn4l0MyhwYZ1Us/rN6g+LMAo1gkJTQeRi9desxPwyGxCeVpq2
         7ahhcrgijNd/4onbprV3lSPnTFiJfW57vushdRsHyORiEkIadfS/QFUJujQvSa02ZwrP
         lC9Q==
X-Gm-Message-State: ACrzQf0afA5dIkLHw6wubjd+q5FDClyOYeDIYbGQPHJHokaHHHCdrXNh
        AtNcJF0Ot2ogIDVx+ikM+Aqvpn2zAowLzZ0n5yg=
X-Google-Smtp-Source: AMsMyM5taRPFbOOF4sPd7aY0so/SzNkhfsht8cfaVSTa3+s9892AJ6fiiGrOxjeTMzsCVpjulXsSPdnlgg+TttTLn9w=
X-Received: by 2002:a67:d303:0:b0:3a6:89ab:d81e with SMTP id
 a3-20020a67d303000000b003a689abd81emr1965343vsj.17.1665123760940; Thu, 06 Oct
 2022 23:22:40 -0700 (PDT)
MIME-Version: 1.0
Sender: dede15441@gmail.com
Received: by 2002:a59:c7d1:0:b0:2eb:d8fb:348f with HTTP; Thu, 6 Oct 2022
 23:22:40 -0700 (PDT)
From:   Farida Hamed <faridahamed0010@gmail.com>
Date:   Thu, 6 Oct 2022 23:22:40 -0700
X-Google-Sender-Auth: nh18C-S3SbmCROzQaBqz5qAu0_E
Message-ID: <CABa=QoQjA82Jt61jgtTiraZCT_hiGNxuLsOLW=WV676Rx9wExw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

How are you and your family
