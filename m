Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABD7480D9C
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Dec 2021 23:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhL1WLo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Dec 2021 17:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhL1WLn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Dec 2021 17:11:43 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3E2C061574
        for <linux-scsi@vger.kernel.org>; Tue, 28 Dec 2021 14:11:43 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u16so14492849plg.9
        for <linux-scsi@vger.kernel.org>; Tue, 28 Dec 2021 14:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Av10FJHZ16PNlaWBwLeHhLYMKvHi/4lm87heoggNDKA=;
        b=qOXQGTHI/yqWQimFZKubKOgSY4HSdh2Qpf1CHiccd8LlleCY+Mz25xS5NL6Fz1gcST
         A+ptPClmwSrXKinhrYXYPPsz2RAv4Gh8TlN1SCqqrtpEdgIOQl7OoMCLL8GE5oFdN33P
         9iYR1lYs2vu0n7rM7dnbXqT1sLW0fGtJ+EnQa8B6tI3r6sJHi3WIxL4CkXPZ+YJlpbL8
         B7tfuiKKRgYt0UNWijWZXUSMDd4Mbcub9FAj/PUeWxyosbSrvaqSaxlUA761Mbr8R3Py
         Ayg5a3wWSW/rA+y1ugrxoqh2X4pHP/tnSdCHOeTdUu4vj17GAWurwV7dqZ0TLjMv5uqQ
         ekwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Av10FJHZ16PNlaWBwLeHhLYMKvHi/4lm87heoggNDKA=;
        b=RdhpUOLa6fBe9gtbCEjFdD6bFEiDAe1KuttVaPRTLMdzY77nu7restEP+Ep35SRPhA
         NAToE461kjVsg5MeRqQ0a1AWnPrfIS/i+SPeOVv/+4XHUGggtOo6NSHYqe7Yv8qf9tah
         f/O3NrAeqaKDEWR6hFfLL+rGhOXS4MYnjBjdaI0G1OlrZO1etCaWRUr8CJsrKKBqDUV3
         3vo+a5FgdOCa2r7UHC2MQSupueTelc8ou0OTRRDE2pxNQJL9OJYVlewWq6GRXoxOcd69
         2Of1ftmUIfRegYfiTm6d4FFPAjE7ESKY8fBCEUC2oAajRl+Z2nc11QnVo/Fs4aH1GHdO
         OcYA==
X-Gm-Message-State: AOAM533tnkuNOHF8k75xsj+0JmU5S5NDShJt9bDfE6kq1xRezKeGxvJu
        cz0diFE6rNVnBIUPwLOZ/9teHyrYJRzzsFSfIO8=
X-Google-Smtp-Source: ABdhPJxQsxi5XXYcBRsWz7SsyNI/6buR/yifyQT3mOtKY2vu/Ce5fDDVnf37DwhFd2gKF6duOF2aH8ivGX9kgVcL4PI=
X-Received: by 2002:a17:903:1ce:b0:148:ca49:b017 with SMTP id
 e14-20020a17090301ce00b00148ca49b017mr23456719plh.18.1640729503216; Tue, 28
 Dec 2021 14:11:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:4102:0:0:0:0 with HTTP; Tue, 28 Dec 2021 14:11:42
 -0800 (PST)
Reply-To: fionahill.usa@hotmail.com
From:   Fiona Hill <grace.desmond2021@gmail.com>
Date:   Tue, 28 Dec 2021 14:11:42 -0800
Message-ID: <CAOW9D1vGWSSWV8RtrdFbq+NqLNZdXhsnRbmtZgBuse-NB-RT3w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Hi, did you receive my message  i send to you?
