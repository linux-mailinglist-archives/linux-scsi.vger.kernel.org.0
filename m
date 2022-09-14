Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958785B90FA
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Sep 2022 01:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiINXhf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Sep 2022 19:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiINXhe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Sep 2022 19:37:34 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CD931DF0
        for <linux-scsi@vger.kernel.org>; Wed, 14 Sep 2022 16:37:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a21so4055240ljq.7
        for <linux-scsi@vger.kernel.org>; Wed, 14 Sep 2022 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=ShE51VUQ4axb0Bz/NABdTBjNwA+Qofa4jx9r0eRkBes=;
        b=k2M2ZNIpdn7xEOMNqcL5GdC6tdfW+P5XwnuQttFsmlako7YEcDKGGvl1kHc01Kvs0U
         2Qify9hf1enFB76+xEiyVof4/OAmdOW9ajqrJcietmAjrKw+omqu4OXbznTQQnUQffdW
         asgvWRx+VuJYoKynfrOfnq47seroQG1C2R6gFJjhDRmFuF7KwEb6u2ALlGvCTiXTle/I
         iM6cozYwqFGJqYp7kzvSo+wd8KqsmQv2IZvN37uYXHCR6eoz/C33Ogif4GeypgaxUfnq
         GWh7AzBbx0EdbLW4zYEirPcczsuiUW6fkM9uN/M10urhH+8RSbPBzODJIbmHsGDscEGz
         5xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ShE51VUQ4axb0Bz/NABdTBjNwA+Qofa4jx9r0eRkBes=;
        b=NqoEf5KU9AVfPOcZmP79sv2DOxn0o10gExc7ETbucMLeTgO8L93A+8Q0Mw4YyW8NFf
         f5KbXi3/ZA9BZrQ82vVgf/zitPG4bW0XMVZKY+rh/6k0Wb3LbQKjPQt8YkV+tFZi45HJ
         2G7KdivDpWU/ZN+l19nxlo0XpiyneGu7z/v0UWaKe+j+5JKVQgClMJCuf8BXfS8a4od8
         /F+LHKs/zkGpukw98MJtzoahj7O0UWS3DhfhiRSF0k5QvQWMwnPFjVaBYWiHb7eA2V+o
         oOky0Ul6uThSAcnl/mw3jAX2vKpkZ6/NKT5xvHfzdxucAVIOQN5wxz0VeP1TH45HKKiC
         hybQ==
X-Gm-Message-State: ACgBeo3zUnGPoex5QtkUzVSZ/uzNIgjlrRGbykT4gf2csvAN86AgyvoX
        UMHnR61nPoCx/kr47BH88DQkNsddT7vi9oYWkDs=
X-Google-Smtp-Source: AA6agR7EYgYy6szLVA8vENFHiH3Hqw7A/W2CZtdlWSnzo8Y14WwknEYJSnghlP4jE/Jw0PB7o/Rn3czvG6bHFjHaU88=
X-Received: by 2002:a05:651c:1242:b0:26b:eb9e:96c6 with SMTP id
 h2-20020a05651c124200b0026beb9e96c6mr7245937ljh.498.1663198651381; Wed, 14
 Sep 2022 16:37:31 -0700 (PDT)
MIME-Version: 1.0
Sender: anselmenicki@gmail.com
Received: by 2002:a2e:a0c3:0:0:0:0:0 with HTTP; Wed, 14 Sep 2022 16:37:30
 -0700 (PDT)
From:   John Kumor <omaralaji51@gmail.com>
Date:   Wed, 14 Sep 2022 23:37:30 +0000
X-Google-Sender-Auth: vBSLmwFGJ0164yzvC-NTmzMUyl8
Message-ID: <CANbcXbF-8ctGU8q1SXozty5X1ogJizj42VRcHk7ReJ1b61gTiQ@mail.gmail.com>
Subject: It's urgent.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greetings!!
Did you receive my previous email?
Please reply back it=E2=80=99s urgent.
Regards,
Attorney John.
