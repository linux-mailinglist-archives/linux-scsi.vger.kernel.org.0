Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67C778A6C
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfG2LZ1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jul 2019 07:25:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387450AbfG2LZ1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Jul 2019 07:25:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29C4AAF39;
        Mon, 29 Jul 2019 11:25:25 +0000 (UTC)
Subject: Re: [PATCH v2 13/18] sg: add sg v4 interface support
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        bart.vanassche@wdc.com
References: <20190727033728.21134-1-dgilbert@interlog.com>
 <20190727033728.21134-14-dgilbert@interlog.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <a624278d-2185-4aee-8259-6573e69408e9@suse.de>
Date:   Mon, 29 Jul 2019 13:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190727033728.21134-14-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/27/19 5:37 AM, Douglas Gilbert wrote:
> Add support for the sg v4 interface based on struct sg_io_v4 found
> in include/uapi/linux/bsg.h and only previously supported by the
> bsg driver. Add ioctl(SG_IOSUBMIT) and ioctl(SG_IORECEIVE) for
> async (non-blocking) usage of the sg v4 interface. Do not accept
> the v3 interface with these ioctls. Do not accept the v4
> interface with this driver's existing write() and read()
> system calls.
> 
> For sync (blocking) usage expand the existing ioctl(SG_IO)
> to additionally accept the sg v4 interface object.
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>  drivers/scsi/sg.c      | 489 ++++++++++++++++++++++++++++++++---------
>  include/uapi/scsi/sg.h |  37 +++-
>  2 files changed, 420 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 4d6635af7da7..dd779931ada4 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -7,8 +7,9 @@
>   *
>   * Original driver (sg.c):
>   *        Copyright (C) 1992 Lawrence Foard
> - * Version 2 and 3 extensions to driver:
> + * Version 2, 3 and 4 extensions to driver:
>   *        Copyright (C) 1998 - 2019 Douglas Gilbert
> + *
>   */
>  
>  static int sg_version_num = 30901;  /* [x]xyyzz where [x] empty when x=0 */
> @@ -40,10 +41,12 @@ static char *sg_version_date = "20190606";
>  #include <linux/atomic.h>
>  #include <linux/ratelimit.h>
>  #include <linux/uio.h>
> -#include <linux/cred.h> /* for sg_check_file_access() */
> +#include <linux/cred.h>			/* for sg_check_file_access() */
> +#include <linux/bsg.h>
>  #include <linux/proc_fs.h>
>  
> -#include "scsi.h"
> +#include <scsi/scsi.h>
> +#include <scsi/scsi_eh.h>
>  #include <scsi/scsi_dbg.h>
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi_driver.h>
> @@ -99,6 +102,7 @@ enum sg_rq_state {
>  #define SG_ADD_RQ_MAX_RETRIES 40	/* to stop infinite _trylock(s) */
>  
>  /* Bit positions (flags) for sg_request::frq_bm bitmask follow */
> +#define SG_FRQ_IS_V4I		0	/* true (set) when is v4 interface */
>  #define SG_FRQ_IS_ORPHAN	1	/* owner of request gone */
>  #define SG_FRQ_SYNC_INVOC	2	/* synchronous (blocking) invocation */
>  #define SG_FRQ_DIO_IN_USE	3	/* false->indirect_IO,mmap; 1->dio */
> @@ -159,6 +163,15 @@ struct sg_slice_hdr3 {
>  	void __user *usr_ptr;
>  };
>  
> +struct sg_slice_hdr4 {	/* parts of sg_io_v4 object needed in async usage */
> +	void __user *sbp;	/* derived from sg_io_v4::response */
> +	u64 usr_ptr;		/* hold sg_io_v4::usr_ptr as given (u64) */
> +	int out_resid;
> +	s16 dir;		/* data xfer direction; SG_DXFER_*  */
> +	u16 cmd_len;		/* truncated of sg_io_v4::request_len */
> +	u16 max_sb_len;		/* truncated of sg_io_v4::max_response_len */
> +};
> +
>  struct sg_scatter_hold {     /* holding area for scsi scatter gather info */
>  	struct page **pages;	/* num_sgat element array of struct page* */
>  	int buflen;		/* capacity in bytes (dlen<=buflen) */
> @@ -175,7 +188,10 @@ struct sg_request {	/* active SCSI command or inactive on free list (fl) */
>  	struct list_head fl_entry;	/* member of rq_fl */
>  	spinlock_t req_lck;
>  	struct sg_scatter_hold sgat_h;	/* hold buffer, perhaps scatter list */
> -	struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
> +	union {
> +		struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
> +		struct sg_slice_hdr4 s_hdr4; /* reduced size struct sg_io_v4 */
> +	};
>  	u32 duration;		/* cmd duration in milliseconds */
>  	u32 rq_flags;		/* hold user supplied flags */
>  	u32 rq_info;		/* info supplied by v3 and v4 interfaces */
> @@ -235,7 +251,10 @@ struct sg_device { /* holds the state of each scsi generic device */
>  struct sg_comm_wr_t {	/* arguments to sg_common_write() */
>  	int timeout;
>  	unsigned long frq_bm[1];	/* see SG_FRQ_* defines above */
> -	struct sg_io_hdr *h3p;
> +	union {		/* selector is frq_bm.SG_FRQ_IS_V4I */
> +		struct sg_io_hdr *h3p;
> +		struct sg_io_v4 *h4p;
> +	};
>  	u8 *cmnd;
>  };
>  
> @@ -244,12 +263,12 @@ static void sg_rq_end_io(struct request *rq, blk_status_t status);
>  /* Declarations of other static functions used before they are defined */
>  static int sg_proc_init(void);
>  static int sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
> -			int dxfer_dir);
> +			struct sg_io_v4 *h4p, int dxfer_dir);
>  static void sg_finish_scsi_blk_rq(struct sg_request *srp);
>  static int sg_mk_sgat(struct sg_request *srp, struct sg_fd *sfp, int minlen);
> -static int sg_submit(struct file *filp, struct sg_fd *sfp,
> -		     struct sg_io_hdr *hp, bool sync,
> -		     struct sg_request **o_srp);
> +static int sg_v3_submit(struct file *filp, struct sg_fd *sfp,
> +			struct sg_io_hdr *hp, bool sync,
> +			struct sg_request **o_srp);
>  static struct sg_request *sg_common_write(struct sg_fd *sfp,
>  					  struct sg_comm_wr_t *cwp);
>  static int sg_rd_append(struct sg_request *srp, void __user *outp,
> @@ -257,11 +276,11 @@ static int sg_rd_append(struct sg_request *srp, void __user *outp,
>  static void sg_remove_sgat(struct sg_request *srp);
>  static struct sg_fd *sg_add_sfp(struct sg_device *sdp);
>  static void sg_remove_sfp(struct kref *);
> -static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int pack_id);
> +static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int id);
>  static struct sg_request *sg_add_request(struct sg_fd *sfp, int dxfr_len,
>  					 struct sg_comm_wr_t *cwrp);
>  static void sg_deact_request(struct sg_fd *sfp, struct sg_request *srp);
> -static struct sg_device *sg_get_dev(int dev);
> +static struct sg_device *sg_get_dev(int min_dev);
>  static void sg_device_destroy(struct kref *kref);
>  static struct sg_request *sg_mk_srp_sgat(struct sg_fd *sfp, bool first,
>  					 int db_len);
> @@ -274,8 +293,11 @@ static void sg_rep_rq_state_fail(struct sg_fd *sfp,
>  
>  #define SZ_SG_HEADER ((int)sizeof(struct sg_header))	/* v1 and v2 header */
>  #define SZ_SG_IO_HDR ((int)sizeof(struct sg_io_hdr))	/* v3 header */
> +#define SZ_SG_IO_V4 ((int)sizeof(struct sg_io_v4))  /* v4 header (in bsg.h) */
>  #define SZ_SG_REQ_INFO ((int)sizeof(struct sg_req_info))
>  
> +/* There is a assert that SZ_SG_IO_V4 >= SZ_SG_IO_HDR in first function */
> +
>  #define SG_IS_DETACHING(sdp) test_bit(SG_FDEV_DETACHING, (sdp)->fdev_bm)
>  #define SG_HAVE_EXCLUDE(sdp) test_bit(SG_FDEV_EXCLUDE, (sdp)->fdev_bm)
>  #define SG_RS_ACTIVE(srp) (atomic_read(&(srp)->rq_st) != SG_RS_INACTIVE)
> @@ -295,6 +317,7 @@ static void sg_rep_rq_state_fail(struct sg_fd *sfp,
>  
>  #if IS_ENABLED(CONFIG_SCSI_LOGGING) && IS_ENABLED(SG_DEBUG)
>  #define SG_LOG_BUFF_SZ 48
> +#define SG_LOG_ACTIVE 1
>  
>  #define SG_LOG(depth, sfp, fmt, a...)					\
>  	do {								\
> @@ -332,6 +355,10 @@ static void sg_rep_rq_state_fail(struct sg_fd *sfp,
>  static int
>  sg_check_file_access(struct file *filp, const char *caller)
>  {
> +	/* can't put following in declarations where it belongs */
> +	compiletime_assert(SZ_SG_IO_V4 >= SZ_SG_IO_HDR,
> +			   "struct sg_io_v4 should be larger than sg_io_hdr");
> +
>  	if (filp->f_cred != current_real_cred()) {
>  		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
>  			caller, task_tgid_vnr(current), current->comm);
> @@ -347,10 +374,11 @@ sg_check_file_access(struct file *filp, const char *caller)
>  
>  static int
>  sg_wait_open_event(struct sg_device *sdp, bool o_excl)
> +	__must_hold(&sdp->open_rel_lock)

This actually has nothing to do with the sg4 interface support.
Please move out locking annotations into a separate patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
