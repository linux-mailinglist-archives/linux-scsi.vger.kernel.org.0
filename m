Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75730432EB4
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Oct 2021 08:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhJSG7A (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Oct 2021 02:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJSG66 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 19 Oct 2021 02:58:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DF3C06161C
        for <linux-scsi@vger.kernel.org>; Mon, 18 Oct 2021 23:56:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so1260722pjb.5
        for <linux-scsi@vger.kernel.org>; Mon, 18 Oct 2021 23:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=U6DRh35iDE2p5tOKDPkdww8haBCQ8COqDJaEOOQt2zS5iAnIJ8cXE7m1w6b/VniAqA
         J57ftXLbkDdTkmyNyPE17aTJe2KRiA6tIRRRnurLyFtUn6u70F7EZHfwjzErxJH9+njh
         40lF1+ZxvFsk6zqvhL4FkXgPT1/4lTb1TQX+9ywFZuxS0AjbfNLaBidB2ksrz63hKtnd
         +Y99cat45Pn7zpNbeIQG5BCnlRUpOCzMEch03cCTPrjKRLgdoHDNZoxYmLGiiNFi5CEQ
         evTKo9Q3+aIRulFiwCGwEdHw4yhI6uIFkOByYk5GXMkA+n5a7FL5357pFqAd+PZlp9yg
         8pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=pp0kX/JXy/W/f/WVnHWpoZXJdMVL+pz2y7IquB3kHWOtY1mBmMy09+SdZ6Kns2rpIV
         HRfyukPq90n6cWY0UCzvdshIZD0uD6dWE1XC5d4r5ZaxrMdGk5eICw7CDkE9OwJJJ4UP
         UjGRr7/t66yG6nADLoSRYNOYzTP2ziUCpARWGL+7uRqwn6nVA6/qehoR2efe0NBX1Ejb
         XRZHbJJFiE3bDEBpaEyWMU0lZstEbuVKTvQDRQ0QSj480b9sTDPy2B721FWbmdKwNqpC
         OnxyqG5pYibyrVOAUegbNxm4QbkL80hB9CnYGottjxenQUxmydxtK84Fu+q1u0+ci64I
         /ZdQ==
X-Gm-Message-State: AOAM532Nm4BqoCl7VI7M54MqZIhAgDLFvYNYDlqF/RqWyatFn/Xvq6OU
        7IrN3B3fuljdOVPmQtCF+OMIcCf5d2DyxxfjACRn5JTj1rVOgw==
X-Google-Smtp-Source: ABdhPJzGvNcamgp8jgm8+84O38VmNynql34TMgwRfbgim/8oT45Ci+FzRwG2sjUq9qAHcVcYiJvOPtH9QZLNDVDMj0I=
X-Received: by 2002:a17:902:e74a:b0:13f:3538:fca0 with SMTP id
 p10-20020a170902e74a00b0013f3538fca0mr31675657plf.22.1634626605935; Mon, 18
 Oct 2021 23:56:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e2cb:0:0:0:0 with HTTP; Mon, 18 Oct 2021 23:56:45
 -0700 (PDT)
Reply-To: michellebrow93@gmail.com
From:   Michelle Brown <ambrosegnona@gmail.com>
Date:   Mon, 18 Oct 2021 23:56:45 -0700
Message-ID: <CAApYH-pAd493LeCDEV32AJtSMZ-orKU8LFHnd3Sk35cu7d_Dtg@mail.gmail.com>
Subject: Hi, I have something to discuss with you, please reply me
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


