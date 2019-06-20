Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF44C7CA
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 09:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfFTHDI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 03:03:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39455 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfFTHDH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 03:03:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so2147513qta.6
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cza1Jgt9qD35cP+k2ZDhn3eE0/VTsztXDVx6euF1m4Q=;
        b=AvBCcyMsyI/NDCcDOtDQnqDuKhahRLMBmtX0iT1Ls2gpyLgMt/YrgFm3J6lk5Ccsgs
         oGJD3mziUqVsSOAoAcmYE0bF6G1HA1spyIFcrZGFM6SyVB9oXCtpHBl8wmmtQhDLVFdO
         u06fN1a2XWI2R7MD4/FngCQlpCqBsgan4jLJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cza1Jgt9qD35cP+k2ZDhn3eE0/VTsztXDVx6euF1m4Q=;
        b=HnIy4rgRsIR1qXn1ebJ0nvPIIA6vrjwAmUJMIr4n+091hJykdRAjl1SO6utSrm23qL
         5DBcwNvq51694KGYDQ20RQVabWNTVuGfD5q6jB19GSywcd2VYBf+1zfn9hhPdvAXgnkf
         3ryfOONsMBCrLBb0hXk794i3mRDyt1p2+PUty0q0AJsZ7ZV1biMJqboDuRGiC/t81VS3
         r56zQMKBq3hzE5nNfadLk27AQ85+q55V7BC0nbldqQSZxGX+GqJ5UFyrVpveAZ4gxugS
         ogeKGBD4N04594dVjVz8T10KoArkNewfhMlWRmAVg9K/0/qXTNgGxiWqB1up58P3N4xM
         oyhA==
X-Gm-Message-State: APjAAAWCRqgdaFFU95T0QHOb0EdOFv+cTcxqQS9YlHM6z5p4Yjzbr7II
        P9ot9NcgbbPNDMalyZFDVyqX9G2kkflr1KZgHrY7Vg==
X-Google-Smtp-Source: APXvYqx6b9AXO4f7pzAgRbQCicMYc2YE5AWE6Ltib0Ygmy0d77r+j8BfJsBo/AtZXNuZlInVy6Ov8N3nLvJ0z+ROzGo=
X-Received: by 2002:aed:24d9:: with SMTP id u25mr112750793qtc.111.1561014186773;
 Thu, 20 Jun 2019 00:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190614144144.6448-1-thenzl@redhat.com> <yq1k1dixu4q.fsf@oracle.com>
In-Reply-To: <yq1k1dixu4q.fsf@oracle.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 20 Jun 2019 12:37:45 +0530
Message-ID: <CA+RiK66cOL5KEaOZNv+PKdLsYOqOLryfGt9H-e0grTMqtccUzA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mpt3sas
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Tomas Henzl <thenzl@redhat.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Acked-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>


On Wed, Jun 19, 2019 at 6:34 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> > Just few small changes, octal numbers instead of constants etc.
>
> Broadcom folks: Please review!
>
> --
> Martin K. Petersen      Oracle Linux Engineering
