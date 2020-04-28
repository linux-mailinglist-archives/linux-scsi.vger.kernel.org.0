Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C51BB2E2
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Apr 2020 02:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgD1AZO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 Apr 2020 20:25:14 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39728 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgD1AZO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 27 Apr 2020 20:25:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id AEF4E22B35;
        Mon, 27 Apr 2020 20:25:10 -0400 (EDT)
Date:   Tue, 28 Apr 2020 10:25:10 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     himanshu.madhani@oracle.com
cc:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        Nilesh Javali <njavali@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v4 10/11] qla2xxx: Fix endianness annotations in header
 files
In-Reply-To: <8ca5292e-88c6-ecb3-77b7-bd6735f5ccca@oracle.com>
Message-ID: <alpine.LNX.2.22.394.2004281017310.12@nippy.intranet>
References: <20200427030310.19687-1-bvanassche@acm.org> <20200427030310.19687-11-bvanassche@acm.org> <8ca5292e-88c6-ecb3-77b7-bd6735f5ccca@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 27 Apr 2020, himanshu.madhani@oracle.com wrote:

> 
> This looks okay, but i would strongly suggest driver maintainer to 
> verify if this introduces any regression or not.

If the changes don't affect code generation, regression is impossible. 

So, compilers (and cross-compilers) could answer your question, if they 
could achieve sufficient code coverage.

It would be nice if there was a tag that could be added to a patch so that 
CI services could check for compiler output invariance (.s or .i or both).

> 
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
