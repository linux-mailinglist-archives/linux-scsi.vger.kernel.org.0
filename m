Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E011544C4
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Feb 2020 14:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgBFNV5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Feb 2020 08:21:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:43522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBFNV5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Feb 2020 08:21:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08D93AE39;
        Thu,  6 Feb 2020 13:21:56 +0000 (UTC)
Message-ID: <bb273446a0f294e37dc0afb2c450fb761e345260.camel@suse.com>
Subject: Re: [PATCH 0/4] qla2xxx patches for kernel v5.6
From:   Martin Wilck <mwilck@suse.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, "dwagner@suse.de" <dwagner@suse.de>
Date:   Thu, 06 Feb 2020 14:23:22 +0100
In-Reply-To: <20191209180223.194959-1-bvanassche@acm.org>
References: <20191209180223.194959-1-bvanassche@acm.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart, hi Martin,

On Mon, 2019-12-09 at 10:02 -0800, Bart Van Assche wrote:
> Hi Martin,
> 
> Please consider these four small qla2xxx patches for kernel v5.6.
> 
> Thanks,
> 
> Bart.

it seems this series got lost somehow, including the point-to-point
mode fix?

I made some remarks back in December, but they were mostly nitpicks.
The only real issue with this set is that the last patch doesn't apply
cleanly.

Bart, could you resend?

Martin


