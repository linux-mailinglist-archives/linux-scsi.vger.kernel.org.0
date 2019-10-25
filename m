Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEBDE40F8
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Oct 2019 03:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbfJYBUd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Oct 2019 21:20:33 -0400
Received: from mellowmood.mkp.net ([104.200.29.94]:59736 "EHLO
        mellowmood.mkp.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388704AbfJYBUd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Oct 2019 21:20:33 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Oct 2019 21:20:33 EDT
Received: from mellowmood.mkp.net (localhost [127.0.0.1])
        by mellowmood.mkp.net (Postfix) with ESMTP id 478C51532;
        Thu, 24 Oct 2019 21:12:32 -0400 (EDT)
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] scsi: lpfc: lpfc_nvmet.c: Fix Use plain integer as NULL pointer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191024030857.GA12097@saurav>
Date:   Thu, 24 Oct 2019 21:12:32 -0400
In-Reply-To: <20191024030857.GA12097@saurav> (Saurav Girepunje's message of
        "Thu, 24 Oct 2019 08:39:01 +0530")
Message-ID: <yq1tv7xbpbz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Saurav,

> Replace assignment of 0 to pointer with NULL assignment.

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
