Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D57AE13CFE
	for <lists+linux-scsi@lfdr.de>; Sun,  5 May 2019 05:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfEEDeh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 4 May 2019 23:34:37 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37802 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfEEDeh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 4 May 2019 23:34:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 111978EE0C7;
        Sat,  4 May 2019 20:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1557027276;
        bh=EMCsSEoeKD2tfQRbUT3DsFzOc7Zxy9wYitORbSIGSyQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Msyze7y8mfbtJc8zDpyufeamAMJK8y4tojihXKqFAbqCBlW84ZJQz2DRFhM1oHVWe
         xz3gfThsH96Pj2PcXs+5Bc4+JiApCH/Advbn4kVm3jxZMoiUynSgis3CE1QzF7ZJCC
         DWePoYa3cEHzoRuofRWoV2H7p/YZLQ7nMNRNZCt0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pCzQJRjBDpxJ; Sat,  4 May 2019 20:34:35 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 41B488EE0A4;
        Sat,  4 May 2019 20:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1557027275;
        bh=EMCsSEoeKD2tfQRbUT3DsFzOc7Zxy9wYitORbSIGSyQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ko9mJbwT396D+BtJT/B6qk4ESXCvhq7qAXbhmpjE4HAY+Ufs044aBYl/ceZufnV+B
         jYHEmfAI1EWQAnZaZd2QWlmipCCp946pf2aT1SXy1BNviCEw4bUe/mDTXm2gpIzYm1
         meyNtO8+UU0fgGaDUi2861jXV9bzmOAiwCRdWeI0=
Message-ID: <1557027274.2821.2.camel@HansenPartnership.com>
Subject: Re: [PATCH] mptsas:  fix undefined behaviour of a shift of an int
 by more than 31 places
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Colin King <colin.king@canonical.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 04 May 2019 20:34:34 -0700
In-Reply-To: <20190504164010.24937-1-colin.king@canonical.com>
References: <20190504164010.24937-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 2019-05-04 at 17:40 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the shift of int value 1 by more than 31 places can result
> in undefined behaviour. Fix this by making the 1 a ULL value before
> the shift operation.

Fusion SAS is pretty ancient.  I thought the largest one ever produced
had four phys, so how did you produce the overflow?

James

