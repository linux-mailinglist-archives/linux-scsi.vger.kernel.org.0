Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF25E3A71BE
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Jun 2021 00:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFNWIV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Jun 2021 18:08:21 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:50474 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhFNWIQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 14 Jun 2021 18:08:16 -0400
Received: from mp-mx11.ca.inter.net (mp-mx11.ca.inter.net [208.85.217.19])
        by mail-1.ca.inter.net (Postfix) with ESMTP id D1AA82EA48B;
        Mon, 14 Jun 2021 18:06:12 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by mp-mx11.ca.inter.net (mp-mx11.ca.inter.net [208.85.217.19]) (amavisd-new, port 10024)
        with ESMTP id 2Afw-ey8Q0mU; Mon, 14 Jun 2021 18:06:12 -0400 (EDT)
Received: from [192.168.48.23] (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 777222EA47F;
        Mon, 14 Jun 2021 18:06:12 -0400 (EDT)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 08/15] scsi: scsi_debug: Remove dump_sector()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20210609033929.3815-1-martin.petersen@oracle.com>
 <20210609033929.3815-9-martin.petersen@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <abcea159-9063-acc2-b853-2674633ca390@interlog.com>
Date:   Mon, 14 Jun 2021 18:06:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609033929.3815-9-martin.petersen@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-06-08 11:39 p.m., Martin K. Petersen wrote:
> The function used to dump sectors containing protection information
> errors was useful during initial development over a decade ago.
> However, dump_sector() substantially slows down the system during
> testing due to writing an entire sector's worth of data to syslog on
> every error.
> 
> We now log plenty of information about the nature of detected
> protection information errors throughout the stack. Dumping the entire
> contents of an offending sector is no longer needed.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Reviewed-by: Douglas Gilbert <dgilbert@interlog.com>

