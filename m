Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC141185CE
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Dec 2019 12:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLJLF4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Dec 2019 06:05:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:57286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726915AbfLJLF4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 10 Dec 2019 06:05:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 500BDAC4B;
        Tue, 10 Dec 2019 11:05:54 +0000 (UTC)
Message-ID: <ee2acb1c03fd5aac55982033b1607ba9c2879480.camel@suse.de>
Subject: Re: [PATCH 1/4] qla2xxx: Check locking assumptions at runtime in
 qla2x00_abort_srb()
From:   Martin Wilck <mwilck@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Date:   Tue, 10 Dec 2019 12:06:44 +0100
In-Reply-To: <20191209180223.194959-2-bvanassche@acm.org>
References: <20191209180223.194959-1-bvanassche@acm.org>
         <20191209180223.194959-2-bvanassche@acm.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2019-12-09 at 10:02 -0800, Bart Van Assche wrote:
> Document the locking assumptions this function relies on and also
> verify these
> locking assumptions at runtime.
> 
> Cc: Quinn Tran <qutran@marvell.com>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/qla2xxx/qla_os.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Martin Wilck <mwilck@suse.com>


