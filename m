Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702F62CF93F
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Dec 2020 05:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgLEEE6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 23:04:58 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40580 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEEE6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 4 Dec 2020 23:04:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 0B1E02B60D;
        Fri,  4 Dec 2020 23:04:12 -0500 (EST)
Date:   Sat, 5 Dec 2020 15:04:18 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Hannes Reinecke <hare@suse.de>
cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 28/37] esp_scsi: use host byte as last argument to
 esp_cmd_is_done()
In-Reply-To: <20201204100140.140863-29-hare@suse.de>
Message-ID: <alpine.LNX.2.23.453.2012051503370.6@nippy.intranet>
References: <20201204100140.140863-1-hare@suse.de> <20201204100140.140863-29-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 4 Dec 2020, Hannes Reinecke wrote:

> Just pass in the host byte to esp_cmd_is_done(), and set the
> status or message bytes if the host byte is DID_OK.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Cc; Finn Thain <fthain@telegraphics.com.au>

Acked-by: Finn Thain <fthain@telegraphics.com.au>
