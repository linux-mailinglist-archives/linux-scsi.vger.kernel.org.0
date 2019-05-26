Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5B2A850
	for <lists+linux-scsi@lfdr.de>; Sun, 26 May 2019 06:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfEZEpv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 May 2019 00:45:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:27228 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfEZEpv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 26 May 2019 00:45:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 May 2019 21:45:50 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 May 2019 21:45:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hUl2a-000FXe-Hm; Sun, 26 May 2019 12:45:48 +0800
Date:   Sun, 26 May 2019 12:45:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: Re: [PATCH 14/19] sg: tag and more_async
Message-ID: <201905261202.l6rPEloA%lkp@intel.com>
References: <20190524184809.25121-15-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524184809.25121-15-dgilbert@interlog.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Douglas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on next-20190524]
[cannot apply to v5.2-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Douglas-Gilbert/sg-v4-interface-rq-sharing-multiple-rqs/20190525-161346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/scsi/sg.c:3193:14: sparse: sparse: incorrect type in assignment (different base types) @@    expected int flgs @@    got restricted blk_mq_req_flaint flgs @@
>> drivers/scsi/sg.c:3193:14: sparse:    expected int flgs
>> drivers/scsi/sg.c:3193:14: sparse:    got restricted blk_mq_req_flags_t
>> drivers/scsi/sg.c:3196:30: sparse: sparse: incorrect type in argument 3 (different base types) @@    expected restricted blk_mq_req_flags_t [usertype] flags @@    got pe] flags @@
>> drivers/scsi/sg.c:3196:30: sparse:    expected restricted blk_mq_req_flags_t [usertype] flags
>> drivers/scsi/sg.c:3196:30: sparse:    got int flgs
   drivers/scsi/sg.c:1180:26: sparse: sparse: cast removes address space '<asn:1>' of expression
   drivers/scsi/sg.c:3605:20: sparse: sparse: incorrect type in initializer (different base types) @@    expected int gfp @@    got restricted gfp_t [usertyint gfp @@
   drivers/scsi/sg.c:3605:20: sparse:    expected int gfp
   drivers/scsi/sg.c:3605:20: sparse:    got restricted gfp_t [usertype]
   drivers/scsi/sg.c:3608:51: sparse: sparse: restricted gfp_t degrades to integer
   drivers/scsi/sg.c:3608:49: sparse: sparse: incorrect type in argument 2 (different base types) @@    expected restricted gfp_t [usertype] flags @@    got  [usertype] flags @@
   drivers/scsi/sg.c:3608:49: sparse:    expected restricted gfp_t [usertype] flags
   drivers/scsi/sg.c:3608:49: sparse:    got unsigned int
   drivers/scsi/sg.c:3610:51: sparse: sparse: restricted gfp_t degrades to integer
   drivers/scsi/sg.c:3610:49: sparse: sparse: incorrect type in argument 2 (different base types) @@    expected restricted gfp_t [usertype] flags @@    got  [usertype] flags @@
   drivers/scsi/sg.c:3610:49: sparse:    expected restricted gfp_t [usertype] flags
   drivers/scsi/sg.c:3610:49: sparse:    got unsigned int
   drivers/scsi/sg.c:1722:1: sparse: sparse: context imbalance in 'sg_ctl_abort' - different lock contexts for basic block
   include/linux/spinlock.h:393:9: sparse: sparse: context imbalance in 'sg_add_request' - different lock contexts for basic block

vim +3193 drivers/scsi/sg.c

  3130	
  3131	static int
  3132	sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
  3133	{
  3134		bool reserved, us_xfer;
  3135		int res = 0;
  3136		int dxfer_len = 0;
  3137		int r0w = READ;
  3138		int flgs;
  3139		unsigned int iov_count = 0;
  3140		void __user *up;
  3141		struct request *rq;
  3142		struct scsi_request *scsi_rp;
  3143		struct sg_fd *sfp = cwrp->sfp;
  3144		struct sg_device *sdp;
  3145		struct sg_scatter_hold *req_schp;
  3146		struct request_queue *q;
  3147		struct rq_map_data *md = (void *)srp; /* want any non-NULL value */
  3148		u8 *long_cmdp = NULL;
  3149		__maybe_unused const char *cp = "";
  3150		struct rq_map_data map_data;
  3151	
  3152		sdp = sfp->parentdp;
  3153		if (cwrp->cmd_len > BLK_MAX_CDB) {	/* for longer SCSI cdb_s */
  3154			long_cmdp = kzalloc(cwrp->cmd_len, GFP_KERNEL);
  3155			if (!long_cmdp)
  3156				return -ENOMEM;
  3157			SG_LOG(5, sdp, "%s: long_cmdp=0x%p ++\n", __func__, long_cmdp);
  3158		}
  3159		if (test_bit(SG_FRQ_IS_V4I, srp->frq_bm)) {
  3160			struct sg_io_v4 *h4p = cwrp->h4p;
  3161	
  3162			if (dxfer_dir == SG_DXFER_TO_DEV) {
  3163				r0w = WRITE;
  3164				up = uptr64(h4p->dout_xferp);
  3165				dxfer_len = (int)h4p->dout_xfer_len;
  3166				iov_count = h4p->dout_iovec_count;
  3167			} else if (dxfer_dir == SG_DXFER_FROM_DEV) {
  3168				/* r0w = READ; */
  3169				up = uptr64(h4p->din_xferp);
  3170				dxfer_len = (int)h4p->din_xfer_len;
  3171				iov_count = h4p->din_iovec_count;
  3172			} else {
  3173				up = NULL;
  3174			}
  3175		} else {
  3176			struct sg_slice_hdr3 *sh3p = &srp->s_hdr3;
  3177	
  3178			up = sh3p->dxferp;
  3179			dxfer_len = (int)sh3p->dxfer_len;
  3180			iov_count = sh3p->iovec_count;
  3181			r0w = dxfer_dir == SG_DXFER_TO_DEV ? WRITE : READ;
  3182		}
  3183		SG_LOG(4, sdp, "%s: dxfer_len=%d, data-%s\n", __func__, dxfer_len,
  3184		       (r0w ? "OUT" : "IN"));
  3185		q = sdp->device->request_queue;
  3186	
  3187		/*
  3188		 * For backward compatibility default to using blocking variant even
  3189		 * when in non-blocking (async) mode. If the SG_CTL_FLAGM_MORE_ASYNC
  3190		 * boolean set on this file descriptor, returns -EAGAIN if
  3191		 * blk_get_request(BLK_MQ_REQ_NOWAIT) yields EAGAIN (aka EWOULDBLOCK).
  3192		 */
> 3193		flgs = (test_bit(SG_FFD_MORE_ASYNC, sfp->ffd_bm)) ?
  3194							BLK_MQ_REQ_NOWAIT : 0;
  3195		rq = blk_get_request(q, (r0w ? REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN),
> 3196				     flgs);
  3197		if (unlikely(IS_ERR(rq))) {
  3198			kfree(long_cmdp);
  3199			return PTR_ERR(rq);
  3200		}
  3201		/* current sg_request protected by SG_RS_BUSY state */
  3202		scsi_rp = scsi_req(rq);
  3203		srp->rq = rq;
  3204	
  3205		if (cwrp->cmd_len > BLK_MAX_CDB)
  3206			scsi_rp->cmd = long_cmdp;
  3207		if (cwrp->u_cmdp)
  3208			res = sg_fetch_cmnd(cwrp->filp, sfp, cwrp->u_cmdp,
  3209					    cwrp->cmd_len, scsi_rp->cmd);
  3210		else if (cwrp->cmdp)
  3211			memcpy(scsi_rp->cmd, cwrp->cmdp, cwrp->cmd_len);
  3212		else
  3213			res = -EPROTO;
  3214		if (unlikely(res)) {
  3215			kfree(long_cmdp);
  3216			return res;
  3217		}
  3218		scsi_rp->cmd_len = cwrp->cmd_len;
  3219		srp->cmd_opcode = scsi_rp->cmd[0];
  3220		us_xfer = !(srp->rq_flags & SG_FLAG_NO_DXFER);
  3221		assign_bit(SG_FRQ_NO_US_XFER, srp->frq_bm, !us_xfer);
  3222		reserved = (sfp->rsv_srp == srp);
  3223		rq->end_io_data = srp;
  3224		scsi_rp->retries = SG_DEFAULT_RETRIES;
  3225		req_schp = &srp->sgat_h;
  3226	
  3227		if (dxfer_len <= 0 || dxfer_dir == SG_DXFER_NONE) {
  3228			SG_LOG(4, sdp, "%s: no data xfer [0x%p]\n", __func__, srp);
  3229			set_bit(SG_FRQ_NO_US_XFER, srp->frq_bm);
  3230			goto fini;	/* path of reqs with no din nor dout */
  3231		} else if (sg_chk_dio_allowed(sdp, sfp, srp, iov_count, dxfer_dir) &&
  3232			   blk_rq_aligned(q, (unsigned long)up, dxfer_len)) {
  3233			set_bit(SG_FRQ_DIO_IN_USE, srp->frq_bm);
  3234			srp->rq_info |= SG_INFO_DIRECT_IO;
  3235			md = NULL;
  3236			if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
  3237				cp = "direct_io, ";
  3238		} else {	/* normal IO and failed conditions for dio path */
  3239			md = &map_data;
  3240		}
  3241	
  3242		if (likely(md)) {	/* normal, "indirect" IO */
  3243			if (unlikely((srp->rq_flags & SG_FLAG_MMAP_IO))) {
  3244				/* mmap IO must use and fit in reserve request */
  3245				if (!reserved || dxfer_len > req_schp->buflen)
  3246					res = reserved ? -ENOMEM : -EBUSY;
  3247			} else if (req_schp->buflen == 0) {
  3248				int up_sz = max_t(int, dxfer_len, sfp->sgat_elem_sz);
  3249	
  3250				res = sg_mk_sgat(srp, sfp, up_sz);
  3251			}
  3252			if (unlikely(res))
  3253				goto fini;
  3254	
  3255			sg_set_map_data(req_schp, !!up, md);
  3256			md->from_user = (dxfer_dir == SG_DXFER_TO_FROM_DEV);
  3257		}
  3258	
  3259		if (unlikely(iov_count)) {
  3260			struct iovec *iov = NULL;
  3261			struct iov_iter i;
  3262	
  3263			res = import_iovec(r0w, up, iov_count, 0, &iov, &i);
  3264			if (unlikely(res < 0))
  3265				goto fini;
  3266	
  3267			iov_iter_truncate(&i, dxfer_len);
  3268			if (!iov_iter_count(&i)) {
  3269				kfree(iov);
  3270				res = -EINVAL;
  3271				goto fini;
  3272			}
  3273	
  3274			if (us_xfer)
  3275				res = blk_rq_map_user_iov(q, rq, md, &i, GFP_ATOMIC);
  3276			kfree(iov);
  3277			if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
  3278				cp = "iov_count > 0";
  3279		} else if (us_xfer) { /* setup for transfer data to/from user space */
  3280			res = blk_rq_map_user(q, rq, md, up, dxfer_len, GFP_ATOMIC);
  3281			if (IS_ENABLED(CONFIG_SCSI_PROC_FS) && res)
  3282				SG_LOG(1, sdp, "%s: blk_rq_map_user() res=%d\n",
  3283				       __func__, res);
  3284		}
  3285	fini:
  3286		if (likely(res == 0)) {
  3287			res = sg_rstate_chg(srp, SG_RS_BUSY, SG_RS_INFLIGHT);
  3288			if (likely(res == 0))
  3289				srp->bio = rq->bio;
  3290		}
  3291		if (unlikely(res && rq)) {		/* failure, free up resources */
  3292			scsi_req_free_cmd(scsi_rp);
  3293			if (likely(!test_and_set_bit(SG_FRQ_BLK_PUT_REQ,
  3294						     srp->frq_bm))) {
  3295				srp->rq = NULL;
  3296				blk_put_request(rq);
  3297			}
  3298		}
  3299		SG_LOG((res ? 1 : 4), sdp, "%s: %s res=%d [0x%p]\n", __func__, cp,
  3300		       res, srp);
  3301		return res;
  3302	}
  3303	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
