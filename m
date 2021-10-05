Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63661421B4F
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Oct 2021 02:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhJEAzX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Oct 2021 20:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJEAzW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Oct 2021 20:55:22 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE12FC061745
        for <linux-scsi@vger.kernel.org>; Mon,  4 Oct 2021 17:53:32 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 194so18291521qkj.11
        for <linux-scsi@vger.kernel.org>; Mon, 04 Oct 2021 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=dbiqOQhkV4brHmNgYUPaK3qcrMQfv2CyqM36P297Q3Y=;
        b=hvRk+zcNlVp0dei0YkMvsKP4l9i6qhKxG+7nCdAAS7HQlOKjKIogHWiRlEczMuvWWD
         pnixXrjrx6WC775qe045q/B/q6Zfb81hcCwX5wPovZCFhuSPRIXLjyBTnT/Ul2MWNRoL
         sRZUMbRrowwlmgKyvREEi3vVfXlEZc/BM4LWycbszCkFWscZpx5tXVMDS2yiIIjTEN/e
         zjZ5SRF3XoD+o8dL2L6m5n0i+s/oXfRr4NavizfRUcNnUp4q5VjgG/lDCaQx6ZpyFbO2
         rHK5ykX0Kzzyt+HpbRPXl5jpPjfcgvU4YTx8tU2OEBBJdRWIFsbHFveNHoVOvUOiu5nP
         0rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=dbiqOQhkV4brHmNgYUPaK3qcrMQfv2CyqM36P297Q3Y=;
        b=CXU7JBlzCjsMK6rnm9pus6FvsBvz6EUTihpnJDkZnJugxXXxBO3AvqDrLxxe4veY+Z
         cCm5rV0x0WGL0byYKjjmRfPlqp+qebfR63cIubZGe1+UrcN55YYlAd7mvouJTmSUcJrp
         bimKleRHgiRnFS8ftmnkrsi3SomWBN/6C5zAU4PzQ4GSWQtRbNJVFnLfNW3v9YVDqIL4
         CH9FUDaSIV9pHJo7So+jDytKwIV97Gu28xKe0/24mAozrzlNT8ZZIR0oZLovcXK+NIpi
         IWvomhWvVlaLAJegtCmxXcT49wyWcHjjGebMtmNrLeRDaUlEDtKytDhhgHFUvWGrBWiQ
         izFA==
X-Gm-Message-State: AOAM533+nsPg0dKL1zcgPd2n1+3l5vk0Cm7XAiWaShllsxajHCSwJWpC
        GC57x04WJaVvVvLXTRptVlIy/mFJrwoS8z6RMLQ=
X-Google-Smtp-Source: ABdhPJwt6cjbaRFAYOPvy2FMaKj34NkRB2FARuGPpqNV5S9J/KanS7HtjESLSj13jjIPMsn8u2Qjx4NyypmGf9BjFaA=
X-Received: by 2002:ae9:d607:: with SMTP id r7mr12869968qkk.142.1633395212136;
 Mon, 04 Oct 2021 17:53:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:45cb:0:0:0:0:0 with HTTP; Mon, 4 Oct 2021 17:53:31 -0700 (PDT)
Reply-To: cherrykona25@hotmail.com
From:   Cherry Kona <fernadezl768@gmail.com>
Date:   Mon, 4 Oct 2021 17:53:31 -0700
Message-ID: <CA+J-fD5farY2V8Xj6rgUxG6UQBPOpPdtNxSgVY7a-o-Dzfzmpg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
You see my message i sent to you?
