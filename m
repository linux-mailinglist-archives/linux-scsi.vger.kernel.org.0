Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8FB2CE14A
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Dec 2020 23:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLCWDu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 3 Dec 2020 17:03:50 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40696 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgLCWDu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 3 Dec 2020 17:03:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 3239222866;
        Thu,  3 Dec 2020 17:03:07 -0500 (EST)
Date:   Fri, 4 Dec 2020 09:02:39 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Hannes Reinecke <hare@suse.de>
cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 27/34] esp_scsi: use host byte as last argument to
 esp_cmd_is_done()
In-Reply-To: <20201202115249.37690-28-hare@suse.de>
Message-ID: <alpine.LNX.2.23.453.2012040851230.6@nippy.intranet>
References: <20201202115249.37690-1-hare@suse.de> <20201202115249.37690-28-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2 Dec 2020, Hannes Reinecke wrote:

> Just pass in the host byte to esp_cmd_is_done(), and set the
> status or message bytes before calling this function.
> 

There are 3 such callsites but in 2 you've not done so.

Are you relying on the mid-layer to initialize the unset bytes to zero?

Wouldn't it be more readable to explicitly set the status and message 
bytes, as per the existing code?
