Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114D5372695
	for <lists+linux-scsi@lfdr.de>; Tue,  4 May 2021 09:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhEDHdZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 May 2021 03:33:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:47480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhEDHdW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 May 2021 03:33:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29392AD09;
        Tue,  4 May 2021 07:32:27 +0000 (UTC)
Subject: Re: Antw: [EXT] Re: [dm-devel] RFC: one more time: SCSI device
 identification
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        erwin@erwinvanlonden.net, martin.petersen@oracle.com,
        martin.wilck@suse.com
Cc:     dgilbert@interlog.com, jejb@linux.vnet.ibm.com,
        "systemd-devel@lists.freedesktop.org" 
        <systemd-devel@lists.freedesktop.org>, hch@lst.de,
        dm-devel@redhat.com, hare@suse.com, linux-scsi@vger.kernel.org
References: <c524ce68d9a9582732db8350f8a1def461a1a847.camel@suse.com>
 <yq135w4cam3.fsf@ca-mkp.ca.oracle.com>
 <06489ea37311fe7bf73b27a41b5209ee4cca85fe.camel@suse.com>
 <yq1pmynt6f6.fsf@ca-mkp.ca.oracle.com>
 <685c40341d2ddef2fe5a54dd656d10104b0c1bfa.camel@suse.com>
 <yq1im4dre94.fsf@ca-mkp.ca.oracle.com>
 <e3184501cbf23ab0ae94d664725e72b693c64ba9.camel@suse.com>
 <6086A0B2020000A100040BBE@gwsmtp.uni-regensburg.de>
 <59dc346de26997a6b8e3ae3d86d84ada60b3d26b.camel@suse.com>
 <b5f288fb43bc79e0206794a901aef5b1761813de.camel@erwinvanlonden.net>
 <15e1a6a493f55051eab844bab2a107f783dc27ee.camel@suse.com>
 <2a6903e4-ff2b-67d5-e772-6971db8448fb@suse.de>
 <6087ECF1020000A100040C7F@gwsmtp.uni-regensburg.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b7d593cc-2adb-1350-be16-39c7c309fdaf@suse.de>
Date:   Tue, 4 May 2021 09:32:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6087ECF1020000A100040C7F@gwsmtp.uni-regensburg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/27/21 12:52 PM, Ulrich Windl wrote:
>>>> Hannes Reinecke <hare@suse.de> schrieb am 27.04.2021 um 10:21 in Nachricht
> <2a6903e4-ff2b-67d5-e772-6971db8448fb@suse.de>:
>> On 4/27/21 10:10 AM, Martin Wilck wrote:
>>> On Tue, 2021‑04‑27 at 13:48 +1000, Erwin van Londen wrote:
>>>>>
>>>>> Wrt 1), we can only hope that it's the case. But 2) and 3) need work,
>>>>> afaics.
>>>>>
>>>> In my view the WWID should never change.
>>>
>>> In an ideal world, perhaps not. But in the dm‑multipath realm, we know
>>> that WWID changes can happen with certain storage arrays. See
>>> https://listman.redhat.com/archives/dm‑devel/2021‑February/msg00116.html
>>> and follow‑ups, for example.
>>>
>> And it's actually something which might happen quite easily.
>> The storage array can unmap a LUN, delete it, create a new one, and map
>> that one into the same LUN number than the old one.
>> If we didn't do I/O during that interval upon the next I/O we will be
>> getting the dreaded 'Power‑On/Reset' sense code.
>> _And nothing else_, due to the arcane rules for sense code generation in
>> SAM.
>> But we end up with a completely different device.
>>
>> The only way out of it is to do a rescan for every POR sense code, and
>> disable the device eg via DID_NO_CONNECT whenever we find that the
>> identification has changed. We already have a copy of the original VPD
>> page 0x83 at hand, so that should be reasonably easy.
> 
> I don't know the depth of the SCSI or FC protocol, but storage systems
> typically signal such events, maybe either via some unit attention or some FC
> event. Older kernels logged that there was a change, but a manual SCSI bus scan
> is needed, while newer kernels find new devices "automagically" for some
> products. The HP EVA 6000 series wored that way, a 3PAR SotorServ 8000 series
> also seems to work that way, but not Pure Storage X70 R3. FOr the latter you
> need something like a FC LIP to make the kernel detect the new devices (LUNs).
> I'm unsure where the problem is, but in principle the kernel can be
> notified...
> 
My point was that while there _is_ a unit attention with the sense code 
'INQUIRY DATA CHANGED' (and that indeed will generate a kernel message), 
it might be obscured by a subsequent unit attention with the sense code 
'Power-On/Reset', as per SCSI spec the latter might cause the previous 
ones to _not_ being sent.
So from that reasoning we will need to rescan the device upon 
'Power-on/Reset'.
But 'Power-On/Reset' is a sense code which we also get during initial 
device scan, so the problem is that we will be triggering a rescan while 
_doing_ a rescan, and as such it would need some really careful testing.

As for the PureStorage behaviour: The problem with changing the LUN 
mapping on the array is that it we might not _have_ a device to send 
unit attentions to.
If the array already exports LUNs to some other hosts, it doesn't need 
to re-initialize the FC port when starting to export LUNs to _this_ 
host. And as _this_ host doesn't have a LUN on which unit attentions can 
be sent, _and_ the FC port is already registered, there are no events 
whatsoever which would cause the host to initiate a rescan.
To resolve that the array would need to induce eg an RSCN, but that will 
only be triggered if a FC port is (re-)registered.
Which is what HPe arrays do; initiate a link-bounce on the attached 
ports, which will cause the attached hosts to initiate a rescan.
Of course, _all_ hosts will need to rescan (and thereby causing an 
interruption even on unrelated hosts), which is why this is not done by 
all vendors.

>>
>> I had a rather lengthy discussion with Fred Knight @ NetApp about
>> Power‑On/Reset handling, what with him complaining that we don't handle
>> is correctly. So this really is something we should be looking into,
>> even independently of multipathing.
>>
>> But actually I like the idea from Martin Petersen to expose the parsed
>> VPD identifiers to sysfs; that would allow us to drop sg_inq completely
>> from the udev rules.
> 
> Talking of VPDs: Somewhere in the last 12 years (within SLES 11)there was a
> kernel change regarding trailing blanks in VPD data. That change blew up
> several configurations being unable to re-recognize the devices. In one case
> the software even had bound a license to a specific device with serial number,
> and that software found "new" devices while missing the "old" ones...
> 
That's probably just for VPD page 0x80. Page 0x83 has pretty strict 
rules on how the entries are formatted, so chopping off trailing blanks 
is not easily done there.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
