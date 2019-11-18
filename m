Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1D10066F
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 14:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfKRN1c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 08:27:32 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34165 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfKRN1b (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 18 Nov 2019 08:27:31 -0500
Received: by mail-io1-f68.google.com with SMTP id q83so18777495iod.1
        for <linux-scsi@vger.kernel.org>; Mon, 18 Nov 2019 05:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VM8ZwkHTDCZEKrTk6igBVYuB+ipWyUTtZ5uGsd+g00=;
        b=nm5otydEGkQO7m/8TnyacwxN+P4yLKQIgYXGDJKaL+2OXo0zK0XfBxhTn8rPsrKZov
         /4QPkwwa3Xdn+aBU97cuZDZPwN6IfELY0/e1ZelC/CqS1E8+tqCtiRWzOyQtFQAd62Su
         5ZKJ1SlQfV3MzuG0HJpsPUELhJN1sqAf8QUufcGyu4nGQCp8RHyje8U/6yeulYk3ToP3
         Fug/nJF7fSk1MIIG2nHPJZTrxaFHZhnauWq4XgwTkTDEqnESdPQfPOGUHE0g/hXtHrwy
         10rGciFRWUxhfqpRpaCuYe5Jb1bA88v1TQF9/96ERty3HkhUJfWWyxd3xPcstnMHJXzO
         SrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VM8ZwkHTDCZEKrTk6igBVYuB+ipWyUTtZ5uGsd+g00=;
        b=LLAaKRdniPqPAmVuCX5TxixuRXP8mLEaWuOY4pELKUA2mz3BrEByJjmwj+Rj+Y+Rmd
         KlJaB209XyIfofmRDJQdQqYYUnajMQYyjevn2/gKdkGa7qw3MIpOVb+cMrWD99waY1jS
         iIiDXx9O6ZrH0vt4ixoAPH/fbZjx0+PRWmxl3SVIFHjTXGWL0uPdkVrCklxxfKxTqi/v
         R8SZFUiHLo5zIkkA2h1Hrj0nHM+0AbsP5GC85dreHK1egpgrLepVc4XNzBsUDoEw+I7Y
         +XV7n9YgD9xYTPOlnw6NitkSXqiepVCS2fbZSAIVd87H0Ww3uwyNUBy8eQ7Xjq7fx7ob
         s1EQ==
X-Gm-Message-State: APjAAAXX6NFrApKteSbCFdj378qrzQIVDRGKWclexyxBzxBNrfAq/87R
        +WLr2tc4uTdEEyWqgcHptIMdphWUOB8vEMhlylA=
X-Google-Smtp-Source: APXvYqyJc8RkUaVIwFm4Ky3enI9FUG4byJ8FEHhFGMFvZQGLJrXR29m+BFWWvCj7r0iYI86cQM3sTWkVqE/XrprzueU=
X-Received: by 2002:a5e:9608:: with SMTP id a8mr12534383ioq.58.1574083650898;
 Mon, 18 Nov 2019 05:27:30 -0800 (PST)
MIME-Version: 1.0
References: <1574049061-11417-1-git-send-email-cang@qti.qualcomm.com>
In-Reply-To: <1574049061-11417-1-git-send-email-cang@qti.qualcomm.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Mon, 18 Nov 2019 18:56:54 +0530
Message-ID: <CAGOxZ50cmTgcCXfzykQtJpO8ahXjhrXioq22s2DK_-W9KMGD0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] UFS driver general fixes bundle 5
To:     Can Guo <cang@qti.qualcomm.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com,
        Mark Salyzyn <salyzyn@google.com>,
        Can Guo <cang@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Can

On Mon, Nov 18, 2019 at 9:21 AM Can Guo <cang@qti.qualcomm.com> wrote:
>
> This bundle includes 4 general fixes for UFS driver.
>
> Changes since v1:
> - Incorporated review comments from Avri Altman.
> - Removed change "scsi: ufs: Add new bit field PA_INIT to UECDL register".
> - Updated change "scsi: ufs: Complete pending requests in host reset and restore path".
>
> Asutosh Das (1):
>   scsi: ufs: Recheck bkops level if bkops is disabled
>
> Can Guo (3):
>   scsi: ufs: Update VCCQ2 and VCCQ min/max voltage hard codes
>   scsi: ufs: Avoid messing up the compl_time_stamp of lrbs
>   scsi: ufs: Complete pending requests in host reset and restore path
>
>  drivers/scsi/ufs/ufs.h    |  4 ++--
>  drivers/scsi/ufs/ufshcd.c | 31 +++++++++++++++----------------
>  drivers/scsi/ufs/ufshcd.h |  2 ++
>  3 files changed, 19 insertions(+), 18 deletions(-)
>
> --

For this bundle, most of the review is done, so if you can send V3 of
these with the addressed 2/4 patch, this can merged.
Thanks

> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
Regards,
Alim
