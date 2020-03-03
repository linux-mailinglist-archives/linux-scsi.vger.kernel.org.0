Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8FC17714A
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Mar 2020 09:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCCIbI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Mar 2020 03:31:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:59666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCCIbI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 3 Mar 2020 03:31:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB3FEAE79;
        Tue,  3 Mar 2020 08:31:06 +0000 (UTC)
Date:   Tue, 3 Mar 2020 09:31:06 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH 4/4] qla2xxx: Fix the code that reads from mailbox
 registers
Message-ID: <20200303083106.yf6whnqaroyiqmo3@beryllium.lan>
References: <20200302033023.27718-1-bvanassche@acm.org>
 <20200302033023.27718-5-bvanassche@acm.org>
 <20200302184312.6uunsrgpxqjznsdz@beryllium.lan>
 <7c8959b8-5b4a-d65c-ae21-b8fe2c7d0680@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c8959b8-5b4a-d65c-ae21-b8fe2c7d0680@acm.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> > I would prefer lower case for the inline function names.
> 
> How about doing that as a separate patch such that this patch can remain
> small and readable?

Sure, fine with me.
