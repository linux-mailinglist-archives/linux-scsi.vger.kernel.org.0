Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0113B346E
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Jun 2021 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhFXRL6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Jun 2021 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhFXRL4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Jun 2021 13:11:56 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2320C0613A3
        for <linux-scsi@vger.kernel.org>; Thu, 24 Jun 2021 10:09:32 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b5so7029939ilc.12
        for <linux-scsi@vger.kernel.org>; Thu, 24 Jun 2021 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=p95plxgcKdT8+TUJCmcKdAyJL6L8C+j3muAeTI6tbvEOMwKUFZvBH22Z3GEGxdnUZH
         d9XkDasjcz/bUj2n1PkWxPPQL/Sxtf1a7ckN43IkWwU4a9v6DYeOi9Tg8DPYHl700hH/
         xlmv54Ir2NUVB8zwaX1UsxTzP5GUW3mdywmszCeflzWKbXzDgkMNhx+qVsi3FklHnD5x
         fSDWvxz3POXOJ/0yZM+F2G99rPMTFJK+bPA5TWYu0VJpvpEjmQwRSgXLB6dx+kXpC0Uz
         JX+JhI0lSB7VkwJTdkbApCrUx6TGzp99N5mAm/d0lil4hmexz93RFAPSpMzmwkjNchKB
         rXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=kgadwHNxMjkVBdWnF2DFZ3ozPgD5/u3F5XkehCtaoRWp9Uzotvn50674cpivWfhN2N
         srPCXeUFhbRBEem/HYkVDz1BSDiZeqCAbNkfh9zvZsY9ZBhumXctUcZWiboKaHnebNaR
         RmjAi5g2lFj/UZSo0PrVV1sElZLpK6zSrdp/AEoZWqDaVCvJoFiG9E7wwynSK0q8jguj
         UNMAMOn3wl3J0JeGH1OJrPSh3tEtteIuILqdjVtzSw1j8ca3PYTI3DLcEfSlyNOBJAKe
         qvFhMieQ5uO4moPYM4dZK0rwXlxwz6PWjl5uF5WgChsR2HrzcU7Ck3SEVpIFT4M/eRfU
         nCbg==
X-Gm-Message-State: AOAM530tetBVW8LaqOYZ6yFN+et9QcJM2So3OT+HZQYVW5mIH6pebX6s
        qlsBKlkM55c2pSAFelJf0OwjL8b0Sd2x9MTag4EVtm34j1cPug==
X-Google-Smtp-Source: ABdhPJzkYUuO368jts0QgMQyJe9SHzg0U698qd8KdfojEfYsXnHtwMfPGxVHmw7fwQ64+IhHRhAEJH5nusdeW4BWzcA=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr4098121ils.255.1624554560853;
 Thu, 24 Jun 2021 10:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:09:20
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:09:20 +0000
Message-ID: <CADB47+607zNBfYFb4bj0nUhuuYgAdwT=G_wJ9-EeV0ESHe56Jg@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
