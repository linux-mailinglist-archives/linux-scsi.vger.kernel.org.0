Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBD9302585
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Jan 2021 14:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbhAYNbg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 Jan 2021 08:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbhAYNbQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 25 Jan 2021 08:31:16 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE59BC0617AB
        for <linux-scsi@vger.kernel.org>; Mon, 25 Jan 2021 05:28:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a20so5421442pjs.1
        for <linux-scsi@vger.kernel.org>; Mon, 25 Jan 2021 05:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=39Ly1vlQghNZDRk1ZCRTC894DiQErhCbN60A7BEMpj0=;
        b=XiaXmq0n0YZxrz18lpcuQvf/QPOKbE3kMURNEjxTTrb7jHS7JL5qFqtjnfyuSzP+OT
         AxtINwa2WlhuvQ10pTatyus1nuAK0k3QljZCupl7EmJ+IMQsUzCaaxCFAluwuFimnhs1
         hMj7qV+uznF+D9/CzrHXFvsK/mta+lmE3nDIT1xDvV3tThbCCT27md+eSlZsS1qauQbC
         ohEO7uBk9Owxm/m+zvalYi/ZRZBxC21/T631AkfXQt3Z4+vxD04+TyxlW/om+BRTSv3+
         Lnb2ONTSwyj+RvbQM4FQgMWNj6CM2t1+QHzivAojhNG8h9AK+Bu8RwssjPf3jrz+U0PP
         Nkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=39Ly1vlQghNZDRk1ZCRTC894DiQErhCbN60A7BEMpj0=;
        b=mJS1EzXNH8CX/E4++r3pwGERPSyMX+3WeodjofEOkrMwZeR6WFj8hOSk6vJBwkZ75S
         xIFLot1SHKyE4SdCn3FKhJtPA7wUpDKntn5+Uxj0neKyD1dGeUL0jN4gsdxZdx1+jb8b
         oy/PEaKMQWlzJaQ72CdfkQ9rEA8nENH4L6A/wh9iaptpBD62CdS+d7rog8bIkGuu0h9e
         qNcqs6i110yxcRS0zlx7OpQIXnnDAjkG4H0SgQBpnyR0Z0TjnyBs5aqX2XN3SAz/mJCy
         fYuRq2jF0C5pHjOPYy07Ounp7/ZwWR+FU8XdPqREuccsExzo0Z9gEr82E+434E6ZHSGB
         dcVQ==
X-Gm-Message-State: AOAM531+tvr9nybAQfNfaCLhB1NeBV5u4Qru9SNf8xz+lsDxexVT2l3Z
        bmI3T8gdeIU4/r0gGMJOTOXTfRuWMgb1HtB6hSU=
X-Google-Smtp-Source: ABdhPJwWYuJkhSJ/UndIXMGjVvPv6v+l2c7k3cPkpJDvsj2mVzu4Xw5W0lmB2+wD2Y4K2EWgNnVAyZXVW/nFsd7ZQY8=
X-Received: by 2002:a17:90a:6643:: with SMTP id f3mr154456pjm.33.1611581338438;
 Mon, 25 Jan 2021 05:28:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:4307:0:0:0:0 with HTTP; Mon, 25 Jan 2021 05:28:58
 -0800 (PST)
Reply-To: hkmohammedh@gmail.com
From:   Mohammed Hossain <rw4602735@gmail.com>
Date:   Mon, 25 Jan 2021 13:28:58 +0000
Message-ID: <CALYF9WR9-9ovr-S=erhzovw_BSbhoFOrWcYTcWm+82E+J5djEg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
I have an proposal for you
Regards
Mohammed Hossain
