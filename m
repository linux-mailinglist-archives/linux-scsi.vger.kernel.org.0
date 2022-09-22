Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D925E652D
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Sep 2022 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiIVO0P (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Sep 2022 10:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiIVOZu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 22 Sep 2022 10:25:50 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F49A8332
        for <linux-scsi@vger.kernel.org>; Thu, 22 Sep 2022 07:25:49 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-346cd4c3d7aso100439857b3.8
        for <linux-scsi@vger.kernel.org>; Thu, 22 Sep 2022 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=jykim3sD7w1OkYSM7Q+3i1V7E+acKHrVct2kMXb/55M=;
        b=W03fwFROUSeNVERuaj9om8JobVZ9zoOImF0UjR7ftwVauoy00RTOhqoji2WGAybdFC
         W2lsQz9UGbzEVSyvlipouxRxh5tUkplqUN6tTByZGnfUJNfpyVhzImqhinixjLX5RAzZ
         7Rtu913G5rzm0fSOdR5DI9lvm7P3AroKIG75AuL/oCZHK8uxaS53ygS4gNPO+RJMnIp0
         cTh9yE5omMd1BFNNH/BzZzaHWmwqYfG+ZAQfBVVtlgi/QvxB5M+zpAWcK+6erQIDlGMB
         u1/5x29TrBWrhvb7LEPk6r3MnxTE5VP7D6xVxQt1Sros9oB/nGNECJI+ARFePgOei3BQ
         nbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=jykim3sD7w1OkYSM7Q+3i1V7E+acKHrVct2kMXb/55M=;
        b=UuI28QMeavs4vXWV6cqe1Ip1Rk+KD7wFEiGmLVSQa2V2bCTvZL77yF13xCp4U0NDcC
         /gdfBaif2MWLgAR3ie/61s0s9yB0srFs6z/H/uKQje2xfR5Yjb6o15g/NQuKkjG1KDf8
         PmvhsVNglP2spqtGYRH5QRoAfK19X5PSDiM1cTrs+8EGq8p3sq7VvCpPBHpNUM8WOeYu
         EFqtruMukeeC5zyjdKi+SYDWLzhnzADd9f1F04WbDDhw2kxRRewNylj45nmT7HkQxAnl
         feObwr6+UMOorb7UItcbk6wnn1OWnGj2ayYbI2UWiTCoWbriksoi9IbvvUQNC3Smp58G
         QQig==
X-Gm-Message-State: ACrzQf2a2T6GWOZIpfuvfjQstJ22HLvVdh+xttQsSU7auEqKdrUV+06a
        A/nN+0idlPj9xZPC+3W2v2MK3RgJT1a2vpemSIA=
X-Google-Smtp-Source: AMsMyM4Szktqa41nSiWbwJ9FzBO+BtE3zGN3VlbE7jZ/zrL5n1Ub76suBUS+M8rkaO1+gX3aaLKqfaaURWNdwhqD2Uc=
X-Received: by 2002:a81:3941:0:b0:345:594e:ef06 with SMTP id
 g62-20020a813941000000b00345594eef06mr3378022ywa.179.1663856748287; Thu, 22
 Sep 2022 07:25:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:1cf7:0:0:0:0 with HTTP; Thu, 22 Sep 2022 07:25:47
 -0700 (PDT)
From:   frg411 <minekporleopold@gmail.com>
Date:   Thu, 22 Sep 2022 14:25:47 +0000
Message-ID: <CAOL8c_M6Q+TMfYMP48YnQqRkNObYP5d91zfQxpGn4Z2n8daD_g@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello. I hope this email is valid?

Regards.
Sami Alkhaldi. from Palestine.
