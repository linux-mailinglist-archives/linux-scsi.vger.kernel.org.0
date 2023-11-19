Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BE57F04DF
	for <lists+linux-scsi@lfdr.de>; Sun, 19 Nov 2023 10:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKSJBD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 19 Nov 2023 04:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKSJBC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 19 Nov 2023 04:01:02 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA598C2
        for <linux-scsi@vger.kernel.org>; Sun, 19 Nov 2023 01:00:58 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so4644366a12.2
        for <linux-scsi@vger.kernel.org>; Sun, 19 Nov 2023 01:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700384457; x=1700989257; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S1JAwuZcaxKjV8o/lzqh5tCVyk7jnBIk/8uUF161tfM=;
        b=XJU49EHHXEL//Fk0cGQXrjiyzayahqNKjVrBR8NhGFCBdA60mD8EuQm+7MDRS1Iof0
         PDVOVkwTS0zftVz9vjNpTvWO5pwQb9Fs7WEBK7kHOZeEE7hiDVRajJpqLzDOqlKl8M9Q
         Z57FoaGuHQuNZuoih5kleIateCHf1GV7G0ttsBL9FPZsyf/Wid5xWlH0X7chmwMCMeNl
         cpgU0DR4ZIQ9wp14z6n4cp8nQgU1QVAGKz51FovdulpOnOXrJJjeuXbNEJCEPl2mVfjO
         gpMjlzQh1bx1qQq4Uz83Yk8NHbyB3iPT7BbWOud35WMXEWeKmLBXXIukd2kBYuOiD2GP
         XfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700384457; x=1700989257;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1JAwuZcaxKjV8o/lzqh5tCVyk7jnBIk/8uUF161tfM=;
        b=OIQUZHLcpYwhEM00E6lkPXaJ63/UuX0wEm35XZXmFimXoLog99Vdr5D65oQizAKl9Q
         +NK1ASbFuE27Bnvglud3cpmJ/D+lg5I2Fv5Mdn4H9P2GK0Jch/0BN6cLQow6Xl50FH/k
         X8shajK1pBYuaYi1r3IdcfGcSDM8tNfSPzb9lzbcgjsE/C+U37eV7r1QD+ppOXq3ZOe7
         YlTaS8wRkjsVDEr61Sbe1w03WG8qwDb3qJ4TwwvY1zJi4eEO2ofQ5nLElgBDbj57GHxs
         0T2ZA/CfY4gs5v/z2AZbEftLLYtw5xwBzPOY+hHkHjhffgbMxuWg5Nabp3i/0g1hv8NH
         1C/A==
X-Gm-Message-State: AOJu0YzanlIIy4rOy4wg8H7YNzjkR4vrce+5QKDrYkl5p2Z+7pHQszz1
        ZMcZoDxakYoH5P11avN0hOG+4TDs+Z7yj4gbDrA=
X-Google-Smtp-Source: AGHT+IFZjZfx2vQ4if9ymu/0Qy2NVzf+AJoiWznMCsMM5IPC2fCMCvxIItmgCYRTHQRps57Ad0qAb0ErbfR72xgWKg0=
X-Received: by 2002:a17:907:b9cc:b0:9c1:66cc:1d7d with SMTP id
 xa12-20020a170907b9cc00b009c166cc1d7dmr2515533ejc.64.1700384456628; Sun, 19
 Nov 2023 01:00:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:678f:b0:5d:9432:e3f7 with HTTP; Sun, 19 Nov 2023
 01:00:56 -0800 (PST)
From:   audu bello <d12u819@gmail.com>
Date:   Sun, 19 Nov 2023 10:00:56 +0100
Message-ID: <CAE8=1O1p7-nVO6f6DuM6c8rfqU_q_wd5CH0wmPeixRg8QrRMTw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_75_100 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

AN EMAIL WAS SENT TO YOU ABOUT RECEIVING A PENDING FUNDS BUT I'M
SURPRISED THAT YOU NEVER BOTHERED TO RESPOND.

PLEASE URGENTLY USE MY REGULAR EMAIL ADDRESS:  mgr.audu@yahoo.com
YOURS FAITHFULLY
AUDIT MANAGER
