Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5013718ADD
	for <lists+linux-scsi@lfdr.de>; Thu,  9 May 2019 15:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEINiY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 May 2019 09:38:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfEINiY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 May 2019 09:38:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA972307EAA2;
        Thu,  9 May 2019 13:38:22 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10DC05D710;
        Thu,  9 May 2019 13:38:21 +0000 (UTC)
Message-ID: <4f852f3f6bf0aa4e79b1ea7ef87476132709d2a5.camel@redhat.com>
Subject: Re: [PATCH 2/2] qla2xxx: Add cleanup for PCI EEH recovery
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
Date:   Thu, 09 May 2019 09:38:21 -0400
In-Reply-To: <20190506205219.7842-3-hmadhani@marvell.com>
References: <20190506205219.7842-1-hmadhani@marvell.com>
         <20190506205219.7842-3-hmadhani@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 09 May 2019 13:38:24 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2019-05-06 at 13:52 -0700, Himanshu Madhani wrote:
> From: Quinn Tran <qutran@marvell.com>
> 
> During EEH error recovery testing, it  was discovered that
> driver's reset() callback partially frees resources used by driver,
> leaving some stale memory.  After reset() is done and when  resume()
> callback in driver uses old data which results into error leaving
> adapter disabled due to PCIe error.
> 
> This patch does cleanup for EEH recovery code path and prevents
> adapter from getting disabled.
> 
> Signed-off-by: Quinn Tran <qutran@marvell.com>
> Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
> ---
>  drivers/scsi/qla2xxx/qla_os.c | 221 ++++++++++++++++--------------------------
>  1 file changed, 82 insertions(+), 139 deletions(-)
> 
> 

Reviewed-by: Ewan D. Milne <emilne@redhat.com>

