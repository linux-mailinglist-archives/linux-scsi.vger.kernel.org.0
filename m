Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96AA36FB98
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Apr 2021 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhD3Nge (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Apr 2021 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhD3Ngd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 30 Apr 2021 09:36:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED2FC06174A
        for <linux-scsi@vger.kernel.org>; Fri, 30 Apr 2021 06:35:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2so17431661lft.4
        for <linux-scsi@vger.kernel.org>; Fri, 30 Apr 2021 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=fRuQgBk1qJpL9RFKJ8KRoQeba9WnDpQFqPKUFon1dCngMXinu4CDIwnY4ryWW3Sqav
         9O5qFaXTZ4oWDwSBAQyYnotbikx5k7L8h1w7gzEm0mBTeCgNjbv8iqg6fB7O/O3w/Bfn
         rfoxbAOd4EZ+4Bl9mdP7hqVpgAoUANE73GyBKCY2CDd9SJ5Oi8LDt2MFj88hNBVi9UXC
         crBHxltP2AV+2oaMOi3XvHC6N717uV2SL2mPz9U4K0hhASBsNXoNuSJ8Y99Z8EsBCTxw
         fA//Se/Q5gIChh8KZOfy5KDDxhxwOo/KKWbyLyLplrZ6rqQ7qQhRCYxoc/xdbUs+Dxh7
         eFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=e0318+X9mYdv7w6OY9mMd10/astv6y+RrxxOI9WJeaRYbFcrT/XGMaSWySINZxOMpJ
         QHH1zIvZZZPhvVD2bMI+hGPuMSTVivnSh0DOnl+EHWBSefIYpVM5iMUewEAE3E/bi8Pn
         iBO+0VEoN1Kk70Wj5TFV+FukNbFMUiWLa8//O+DBg3ZSVZ1p90rFm1QEAe/sd0vErgqB
         uOcgroXNPBKvPFvkc0mNWHjEYsvra/NU/tbxbW9wfleLK++iF31OqRqRFjUCKqPwebEw
         6SRC38Trh02NsMgnWR9RMO9mM62b0wOif95eJvEiMMSnPVkTm/+tsQTzDMIkwVKVrTPk
         mi+w==
X-Gm-Message-State: AOAM530il39ty+lxIqrIcOmTdHADt+Ng7cfa0PE4ToUBsanrdmyzGfKv
        9dUmPwGyKIu7Tqk19y6ZeE6I82hRB0kQkOSEGQM=
X-Google-Smtp-Source: ABdhPJyC06xYOcoyEX/MpHUB7qCFMkOPBAW0xUj8qfF49SuiMqGxRjE7+Pnr2uIFVRcLj3/BC7wUNe3Qp0SVtP6/tMc=
X-Received: by 2002:a05:6512:3d8b:: with SMTP id k11mr3467893lfv.218.1619789742243;
 Fri, 30 Apr 2021 06:35:42 -0700 (PDT)
MIME-Version: 1.0
Sender: djabakuclarisse@gmail.com
Received: by 2002:a05:6504:1086:0:0:0:0 with HTTP; Fri, 30 Apr 2021 06:35:41
 -0700 (PDT)
From:   kayla manthey <sgtmanthey1@gmail.com>
Date:   Fri, 30 Apr 2021 13:35:41 +0000
X-Google-Sender-Auth: hmc0MoPJs5wTuEDzZUX79664bZA
Message-ID: <CAMu5PMDC7i4wsibH47N0JmWctfjBDBOYXXNOZ9hCX=qdBcywQA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

K=C3=A9rem, szeretn=C3=A9m tudni, hogy megkapta-e az el=C5=91z=C5=91 =C3=BC=
zeneteimet.
