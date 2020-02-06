Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8818C154D8C
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Feb 2020 21:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBFUvX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Feb 2020 15:51:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:40626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbgBFUvX (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Feb 2020 15:51:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00DA2ACB1;
        Thu,  6 Feb 2020 20:51:21 +0000 (UTC)
Message-ID: <cb2ad8b48a412ad164ebbe809bc80b238b16a0b4.camel@suse.com>
Subject: Re: [PATCH 0/4] qla2xxx patches for kernel v5.6
From:   Martin Wilck <mwilck@suse.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, "dwagner@suse.de" <dwagner@suse.de>
Date:   Thu, 06 Feb 2020 21:52:48 +0100
In-Reply-To: <559ee60f-43e8-b228-f14b-7453d62e7780@acm.org>
References: <20191209180223.194959-1-bvanassche@acm.org>
         <bb273446a0f294e37dc0afb2c450fb761e345260.camel@suse.com>
         <559ee60f-43e8-b228-f14b-7453d62e7780@acm.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2020-02-06 at 12:49 -0800, Bart Van Assche wrote:
> 
> The first patch of this series has been queued by Martin Petersen
> for 
> the v5.7 merge window. I plan to repost patches 2/4 and 4/4 of this 
> series after the merge window has closed. Patch 3/4 (the fix for 
> point-to-point mode) has been dropped because I'm not confident that
> my 
> fix is a proper fix.

Well, Himanshu had ack'd it, and Roman too IIRC ... have you given up
on the subject?

Martin


