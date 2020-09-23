Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4431A275366
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Sep 2020 10:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIWIic (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Sep 2020 04:38:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:56576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgIWIic (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 23 Sep 2020 04:38:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF5FCB220;
        Wed, 23 Sep 2020 08:39:08 +0000 (UTC)
Subject: Re: [EXT] Re: [PATCH 0/2] SAN Congestion Management (SCM) statistics
To:     Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Smart <james.smart@broadcom.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>
References: <20200730061116.20111-1-njavali@marvell.com>
 <DM6PR18MB3052C2991B834B3A93D96E69AF280@DM6PR18MB3052.namprd18.prod.outlook.com>
 <yq1imcn4q6y.fsf@ca-mkp.ca.oracle.com>
 <DM6PR18MB3052AD22FD8D495CEF4948B7AF3E0@DM6PR18MB3052.namprd18.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c7dac10f-1bd1-7cb1-29c0-84cd22f991c6@suse.de>
Date:   Wed, 23 Sep 2020 10:38:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR18MB3052AD22FD8D495CEF4948B7AF3E0@DM6PR18MB3052.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/17/20 6:53 PM, Nilesh Javali wrote:
> James,
> 
> A gentle reminder to review the SCM statistics changes.
> 
As James already pointed out, please separate out the first patch into 
individual pieces.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
