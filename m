Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95836C60A
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbhD0M2L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Tue, 27 Apr 2021 08:28:11 -0400
Received: from fgw21-4.mail.saunalahti.fi ([62.142.5.108]:30793 "EHLO
        fgw21-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235410AbhD0M2L (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 08:28:11 -0400
X-Greylist: delayed 962 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Apr 2021 08:28:10 EDT
Received: from smtpclient.apple (87-92-207-71.rev.dnainternet.fi [87.92.207.71])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTPSA
        id aeba7566-a751-11eb-9eb8-005056bdd08f;
        Tue, 27 Apr 2021 15:11:23 +0300 (EEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH 01/40] st: return error code in st_scsi_execute()
From:   =?utf-8?B?IkthaSBNw6RraXNhcmEgKEtvbHVtYnVzKSI=?= 
        <kai.makisara@kolumbus.fi>
In-Reply-To: <20210427083046.31620-2-hare@suse.de>
Date:   Tue, 27 Apr 2021 15:11:20 +0300
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <23468351-434A-42AE-BB52-B839A4B1085C@kolumbus.fi>
References: <20210427083046.31620-1-hare@suse.de>
 <20210427083046.31620-2-hare@suse.de>
To:     Hannes Reinecke <hare@suse.de>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



> On 27. Apr 2021, at 11.30, Hannes Reinecke <hare@suse.de> wrote:
> 
> The callers to st_scsi_execute already check for negative
> return values, so we can drop the use of DRIVER_ERROR and
> return the actual error code.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Kai Mäkisara <kai.makisara@kolumbus.fi>

