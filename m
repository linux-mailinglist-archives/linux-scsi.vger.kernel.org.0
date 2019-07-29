Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0300E784E2
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 08:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfG2GVi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jul 2019 02:21:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:46564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfG2GVi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Jul 2019 02:21:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A39C6ADFC;
        Mon, 29 Jul 2019 06:21:36 +0000 (UTC)
Subject: Re: [PATCH 4/4] Reduce memory required for SCSI logging
To:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jan Palus <jpalus@fastmail.com>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org
References: <20190726164855.130084-1-bvanassche@acm.org>
 <20190726164855.130084-5-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <5fcb2eb5-3eb2-d6ee-1846-fb26afe39046@suse.de>
Date:   Mon, 29 Jul 2019 08:21:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726164855.130084-5-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/26/19 6:48 PM, Bart Van Assche wrote:
> The data structure used for log messages is so large that it can cause a
> boot failure. Since allocations from that data structure can fail anyway,
> use kmalloc() / kfree() instead of that data structure.
> 
> See also https://bugzilla.kernel.org/show_bug.cgi?id=204119.
> See also commit ded85c193a39 ("scsi: Implement per-cpu logging buffer") # v4.0.
> 
> Reported-by: Jan Palus <jpalus@fastmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jan Palus <jpalus@fastmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/scsi_logging.c | 48 +++----------------------------------
>  include/scsi/scsi_dbg.h     |  2 --
>  2 files changed, 3 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
> index 39b8cc4574b4..c6ed0b12e807 100644
> --- a/drivers/scsi/scsi_logging.c
> +++ b/drivers/scsi/scsi_logging.c
> @@ -15,57 +15,15 @@
>  #include <scsi/scsi_eh.h>
>  #include <scsi/scsi_dbg.h>
>  
> -#define SCSI_LOG_SPOOLSIZE 4096
> -
> -#if (SCSI_LOG_SPOOLSIZE / SCSI_LOG_BUFSIZE) > BITS_PER_LONG
> -#warning SCSI logging bitmask too large
> -#endif
> -
> -struct scsi_log_buf {
> -	char buffer[SCSI_LOG_SPOOLSIZE];
> -	unsigned long map;
> -};
> -
> -static DEFINE_PER_CPU(struct scsi_log_buf, scsi_format_log);
> -
>  static char *scsi_log_reserve_buffer(size_t *len)
>  {
> -	struct scsi_log_buf *buf;
> -	unsigned long map_bits = sizeof(buf->buffer) / SCSI_LOG_BUFSIZE;
> -	unsigned long idx = 0;
> -
> -	preempt_disable();
> -	buf = this_cpu_ptr(&scsi_format_log);
> -	idx = find_first_zero_bit(&buf->map, map_bits);
> -	if (likely(idx < map_bits)) {
> -		while (test_and_set_bit(idx, &buf->map)) {
> -			idx = find_next_zero_bit(&buf->map, map_bits, idx);
> -			if (idx >= map_bits)
> -				break;
> -		}
> -	}
> -	if (WARN_ON(idx >= map_bits)) {
> -		preempt_enable();
> -		return NULL;
> -	}
> -	*len = SCSI_LOG_BUFSIZE;
> -	return buf->buffer + idx * SCSI_LOG_BUFSIZE;
> +	*len = 128;
> +	return kmalloc(*len, GFP_ATOMIC);
>  }
>  
>  static void scsi_log_release_buffer(char *bufptr)
>  {
> -	struct scsi_log_buf *buf;
> -	unsigned long idx;
> -	int ret;
> -
> -	buf = this_cpu_ptr(&scsi_format_log);
> -	if (bufptr >= buf->buffer &&
> -	    bufptr < buf->buffer + SCSI_LOG_SPOOLSIZE) {
> -		idx = (bufptr - buf->buffer) / SCSI_LOG_BUFSIZE;
> -		ret = test_and_clear_bit(idx, &buf->map);
> -		WARN_ON(!ret);
> -	}
> -	preempt_enable();
> +	kfree(bufptr);
>  }
>  
>  static inline const char *scmd_name(const struct scsi_cmnd *scmd)
> diff --git a/include/scsi/scsi_dbg.h b/include/scsi/scsi_dbg.h
> index e03bd9d41fa8..7b196d234626 100644
> --- a/include/scsi/scsi_dbg.h
> +++ b/include/scsi/scsi_dbg.h
> @@ -6,8 +6,6 @@ struct scsi_cmnd;
>  struct scsi_device;
>  struct scsi_sense_hdr;
>  
> -#define SCSI_LOG_BUFSIZE 128
> -
>  extern void scsi_print_command(struct scsi_cmnd *);
>  extern size_t __scsi_format_command(char *, size_t,
>  				   const unsigned char *, size_t);
> 
Nope.

You've just disabled the prime reason why I did implement SCSI logging;
namely to provide per-cpu buffers where messages can be printed into.

We can move to kmalloc (or even kvmalloc), but the per-cpu pointer need
to be kept.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
