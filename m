Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2510A407
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Nov 2019 19:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfKZSZx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Nov 2019 13:25:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:37126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfKZSZx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 26 Nov 2019 13:25:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8602DB3F5;
        Tue, 26 Nov 2019 18:25:51 +0000 (UTC)
Subject: Re: [PATCH 02/11] scsi: add scsi_host_flush_commands() helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20191120103114.24723-1-hare@suse.de>
 <20191120103114.24723-3-hare@suse.de> <20191126165533.GD8204@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9c7abcf8-70ed-dc29-6092-07c2c9a1fee7@suse.de>
Date:   Tue, 26 Nov 2019 19:25:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191126165533.GD8204@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/26/19 5:55 PM, Christoph Hellwig wrote:
> flush is such a heavіly overloaded term.  What about
> scsi_host_complete_all_commands?
> 
Sure. As it happens I've been struggling with the function name, too,
so any meaningful name is good with me.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
